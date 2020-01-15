//
//  NSString+EncodeEmoji.m
//  Bubbling
//
//  Created by MenThu on 2018/7/4.
//  Copyright © 2018年 阿拉丁. All rights reserved.
//

#import "NSString+EncodeEmoji.h"

@implementation NSString (EncodeEmoji)

- (NSArray <NSValue *> *)searchEmoji{
    NSMutableArray <NSValue *> *emojiRangeArray = @[].mutableCopy;
    NSInteger index = 0;
    while (index < self.length) {
        NSRange tempRange = [self rangeOfComposedCharacterSequenceAtIndex:index];
        NSString *tempString = [self substringWithRange:tempRange];
        
        NSMutableString* hexString = [NSMutableString string];
        for (int i = 0; i < tempString.length; ++i) {
            [hexString appendFormat:@"%02x", [tempString characterAtIndex:i]];
        }
        
        NSScanner* scanner = [NSScanner scannerWithString:hexString];
        UInt64 code = 0x00;
        [scanner scanHexLongLong: &code];
        if ([self isNotEmoji:code] == NO) {
            //找到Emoji
            [emojiRangeArray addObject:[NSValue valueWithRange:tempRange]];
        }
        index = tempRange.location + tempRange.length;
    }
    return emojiRangeArray;
}

- (BOOL)isNotEmoji:(UInt64) codePoint {
    return (codePoint == 0x0)
    || (codePoint == 0x9)
    || (codePoint == 0xA)
    || (codePoint == 0xD)
    || ((codePoint >= 0x20) && (codePoint <= 0xD7FF))
    || ((codePoint >= 0xFF00) && (codePoint <=
                                  0xFFFF));
}

- (BOOL)isPureEmoji{
    __weak typeof(self) weakSelf = self;
    __block BOOL returnValue = YES;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if ([weakSelf isSubStringEmoji:substring] == NO) {
                                  returnValue = NO;
                                  *stop = YES;
                              }
                          }];
    return returnValue;
}

- (BOOL)isSubStringEmoji:(NSString *)string{
    const unichar hs = [string characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (string.length > 1) {
            const unichar ls = [string characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                return YES;
            }
        }
    }else if (string.length > 1) {
        const unichar ls = [string characterAtIndex:1];
        if (ls == 0x20e3) {
            return YES;
        }
    }else{
        if (0x2100 <= hs && hs <= 0x27ff) {
            return YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            return YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            return YES;
        }
    }
    return NO;
}

@end
