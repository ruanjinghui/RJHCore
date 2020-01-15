
//  Created by duke on 2017/7/4.
//

#import "UIView+Corners.h"
#import <objc/runtime.h>

@interface UIView ()

@property (assign, nonatomic) QYCornerRadius qy_corners;
@property (assign, nonatomic) CGFloat qy_radius;
@property (assign, nonatomic) CGFloat qy_width;
@property (strong, nonatomic) UIColor * qy_color;

@end

static void * qyCornersKey = &qyCornersKey;
static void * qyRadiusKey = &qyRadiusKey;
static void * qyWidthKey = &qyWidthKey;
static void * qyColorKey = &qyColorKey;

@implementation UIView (Corners)

- (void)cornerRadius:(QYCornerRadius)corners radius:(CGFloat)radius {
    self.qy_corners = corners;
    self.qy_radius = radius;
}

- (void)cornerRadius:(QYCornerRadius)corners radius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    self.qy_corners = corners;
    self.qy_radius = radius;
    self.qy_width = width;
    self.qy_color = color;
}

- (QYCornerRadius)qy_corners {
    return [objc_getAssociatedObject(self, qyCornersKey) integerValue];
}

- (void)setQy_corners:(QYCornerRadius)qy_corners {
    objc_setAssociatedObject(self, qyCornersKey, @(qy_corners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)qy_radius {
    return [objc_getAssociatedObject(self, qyRadiusKey) floatValue];
}

- (void)setQy_radius:(CGFloat)qy_radius {
    objc_setAssociatedObject(self, qyRadiusKey, @(qy_radius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)qy_width {
    return [objc_getAssociatedObject(self, qyWidthKey) floatValue];
}

- (void)setQy_width:(CGFloat)qy_width {
    objc_setAssociatedObject(self, qyWidthKey, @(qy_width), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)qy_color {
    return objc_getAssociatedObject(self, qyColorKey);
}

- (void)setQy_color:(UIColor *)qy_color {
    objc_setAssociatedObject(self, qyColorKey, qy_color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void qy_swizzle(Class c, SEL oriFunc, SEL newFunc) {
    Method oriMethod = class_getInstanceMethod(c, oriFunc);
    Method newMethod = class_getInstanceMethod(c, newFunc);
    method_exchangeImplementations(oriMethod, newMethod);
}

+ (void)load {
    SEL oriFunc = @selector(layoutSublayersOfLayer:);
    SEL newFunc = NSSelectorFromString([@"qy_" stringByAppendingString:NSStringFromSelector(oriFunc)]);
    qy_swizzle(self, oriFunc, newFunc);
}

- (void)qy_layoutSublayersOfLayer:(CALayer *)layer {
    [self qy_layoutSublayersOfLayer:layer];
    
    UIBezierPath * maskPath = nil;
    if (self.qy_radius > 0) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCorner)(self.qy_corners) cornerRadii:CGSizeMake(self.qy_radius, self.qy_radius)];
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }else {
        maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    
    if (self.qy_width > 0) {
        CAShapeLayer * borderLayer = [CAShapeLayer layer];
        borderLayer.path = maskPath.CGPath;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.lineWidth = self.qy_width;
        borderLayer.strokeColor = self.qy_color.CGColor;
        borderLayer.frame = self.bounds;
        [self.layer addSublayer:borderLayer];
    }
}

@end
