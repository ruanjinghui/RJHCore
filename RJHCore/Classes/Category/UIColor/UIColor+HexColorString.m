//
//  UIColor+HexString.m
//  GymLink
//
//  Created by 张艺龙 on 2017/3/14.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import "UIColor+HexColorString.h"

@implementation UIColor (HexColorString)
//add
+ (UIColor *)colorWithHexString:(NSString *)hexColorString alpha:(CGFloat)alpha{
    unsigned colorValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexColorString];
    if ([hexColorString rangeOfString:@"#"].location != NSNotFound) {
        [scanner setScanLocation:1];
    }
    [scanner scanHexInt:&colorValue];
    return [UIColor colorWithRed:((colorValue & 0xFF0000) >> 16) / 255.0 green:((colorValue & 0xFF00) >> 8) / 255.0 blue:((colorValue & 0xFF) >> 0) / 255.0 alpha:alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

// 使用十六进制颜色值
+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

@end
