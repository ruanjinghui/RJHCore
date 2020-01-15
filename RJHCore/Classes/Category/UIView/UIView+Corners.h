//  Created by duke on 2017/7/4.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, QYCornerRadius) {
    QYCornerRadiusLeftTop = 1 << 0,
    QYCornerRadiusRightTop = 1 << 1,
    QYCornerRadiusLeftBottom = 1 << 2,
    QYCornerRadiusRightBottom = 1 << 3,
    QYCornerRadiusTop = QYCornerRadiusLeftTop | QYCornerRadiusRightTop,
    QYCornerRadiusLeft = QYCornerRadiusLeftTop | QYCornerRadiusLeftBottom,
    QYCornerRadiusRight = QYCornerRadiusRightTop | QYCornerRadiusRightBottom,
    QYCornerRadiusBottom = QYCornerRadiusRightBottom | QYCornerRadiusLeftBottom,
    QYCornerRadiusAll = ~0UL,
};

@interface UIView (Corners)

/**
 * 使用贝塞尔曲线切圆角
 * @param corners 通过枚举决定切哪个角, 如果有多个角需要切, 使用位运算符 |
 */
- (void)cornerRadius:(QYCornerRadius)corners radius:(CGFloat)radius;
/**
 * 使用贝塞尔曲线切圆角和边框
 */
- (void)cornerRadius:(QYCornerRadius)corners radius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

@end
