//
//  UIFont+Exten.m
//  Bubbling
//
//  Created by poplar on 2018/6/26.
//  Copyright © 2018年 阿拉丁. All rights reserved.
//

#import "UIFont+Exten.h"

@implementation UIFont (Exten)

+ (UIFont *)fontWithAmerican_size:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:size];
    if (font == nil){
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWithBold_size:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Bold" size:size];
    if (font == nil){
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWithRegular_size:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWithMedium_size:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWithSemibold_size:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWithDINCond_size:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINCondensed-Bold" size:size];
    if (font == nil) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

@end
