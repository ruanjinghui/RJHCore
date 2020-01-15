//
//  NSString+EncodeEmoji.h
//  Bubbling
//
//  Created by MenThu on 2018/7/4.
//  Copyright © 2018年 阿拉丁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncodeEmoji)

/**
 *  是否为纯Emoji表情
 *  @"🙂" 纯Emoji表情
 *  @"Test🙂" 不是纯Emoji表情
 */
- (BOOL)isPureEmoji;

@end
