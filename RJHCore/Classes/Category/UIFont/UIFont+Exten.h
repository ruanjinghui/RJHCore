//
//  UIFont+Exten.h
//  Bubbling
//
//  Created by poplar on 2018/6/26.
//  Copyright © 2018年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Exten)

/**
 * 苹方字体 (粗)
 */
+ (UIFont *)fontWithBold_size:(CGFloat)size;
/**
 * 苹方字体 (常规)
 */
+ (UIFont *)fontWithRegular_size:(CGFloat)size;
/**
 * 苹方字体 (中等)
 */
+ (UIFont *)fontWithMedium_size:(CGFloat)size;
/**
 * 苹方字体 (半黑体)
 */
+ (UIFont *)fontWithSemibold_size:(CGFloat)size;
/**
 * 美式字体 (黑体)
 */
+ (UIFont *)fontWithAmerican_size:(CGFloat)size;

+ (UIFont *)fontWithDINCond_size:(CGFloat)size;

@end
