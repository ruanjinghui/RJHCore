//
//  UIView+ReRect.m
//  GymLink_new
//
//  Created by 张艺龙 on 2017/5/24.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import "UIView+ReRect.h"

@implementation UIView (ReRect)

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}
- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}
- (void)setRight:(CGFloat)right {
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

//top
- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    if (self.frame.origin.y == top) {
        return;
    }
    frame.origin = CGPointMake(frame.origin.x, top);
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

//left
- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    if (self.frame.origin.x == left) {
        return;
    }
    frame.origin = CGPointMake(left,self.frame.origin.y);
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    if (center.x == centerX) {
        return;
    }
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    if (center.y == centerY) {
        return;
    }
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

//size
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    if (CGSizeEqualToSize(frame.size, size)) {
        return;
    }
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.bounds.size;
}

@end
