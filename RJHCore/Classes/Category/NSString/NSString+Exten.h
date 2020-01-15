//
//  NSString+Exten.h
//  Bubbling
//
//  Created by 张艺龙 on 2017/11/8.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Exten)

/** 根据指定宽度. 字体计算文本尺寸 */
- (CGSize)adapterSizeWithMaxWidth:(CGFloat)width WithFont:(UIFont *)font;
/** 根据指定宽度. 字体计算自定义行间距的文本尺寸 */
- (CGSize)adapterSizeWithMaxWidth:(CGFloat)width WithFont:(UIFont *)font WithLineSpacing:(CGFloat)lineSpacing;
/** 判断是否为纯数字 */
- (BOOL)validateNumber;
/** 对字符串进行md5加密 */
- (NSString *)md5String;
/** 对字符串md5加盐 */
- (NSString *)md5Salt;
/** HAS256加密 */
- (NSString *)SHA256;
/** 判断是不是手机号码 */
- (BOOL)isPhoneNumber;
/** 判断是不是合法的用户名，支持数字、汉字、字母,不支 持特殊符号和 emoji 表情 */
- (BOOL)isLegitimateNickName;
/** 判断是不是合法的密码，支持数字、英文输入,英文字母支持大小写，支持特殊字符 */
- (BOOL)isLegitimatePassword;
/** 判断是不是合法的URL */
- (BOOL)isLegitimateURL;
/** 判断是不是合法的Email */
- (BOOL)isLegitimateEmail;
/** 获取字符串中汉字的个数 */
- (NSUInteger)getChineseNumCount;
/** NSString转NSDate */
- (NSDate *)toDateWithFormat:(NSString *)format;
/** 检查是否是有效字符串 */
- (BOOL)isExist;
/**
 去除收尾空格

 @return 去除收尾空格后的串
 */
- (NSString *)trim;
/**
 生成uuid
 @param str 追加字符串
 */
+ (instancetype)generateUUIDStringByAppendingStr:(NSString *)str;
/** 获取urlStr的参数部分 */
- (NSDictionary *)getParameters;
/** 获取首字母 */
- (char)mtkFirstLetterChar;
/**
 按照中文两个字符，英文数字一个字符计算字符数
 */
- (NSUInteger)unicodeLengthOfString;
/**
 时间戳按指定格式转换
 
 @param time 时间戳
 @param timeFormatter @"yyyy-MM-dd HH:mm"
 @return @"yyyy-MM-dd HH:mm" 格式
 */
+ (NSString *)formattedTimeFromTimeInterval:(long long)time withTimeFormatter:(NSString *)timeFormatter;
/**
 * 获当前日期及时间的字符串
 @param formatter @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)getCurrentDateStringWithFormatter:(NSString *)formatter;
/**
 * 获取当前时间的时间戳
 */
+ (NSString *)getCurrentTimeStamp;
/**
 * 秒数(字符串)转换为时间格式的字符串
 * @return HH:mm:ss
 */
- (NSString *)getTimeFromSeconds;
/**
 * 返回一个一定位数的随机字符串
 */
+ (NSString *)getRandomString;

@property (strong, nonatomic) NSDictionary * toDictionary;

@end
