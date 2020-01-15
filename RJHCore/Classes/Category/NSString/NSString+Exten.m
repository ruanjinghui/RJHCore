//
//  NSString+Exten.m
//  Bubbling
//
//  Created by 张艺龙 on 2017/11/8.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import "NSString+Exten.h"
#import "CommonCrypto/CommonDigest.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation NSString (Exten)

// 根据指定宽度. 字体计算文本尺寸
- (CGSize)adapterSizeWithMaxWidth:(CGFloat)width WithFont:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 99999)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size;
}

// 根据指定宽度. 字体计算自定义行间距的文本尺寸
- (CGSize)adapterSizeWithMaxWidth:(CGFloat)width WithFont:(UIFont *)font WithLineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}
                                     context:nil];
    return rect.size;
}

// 判断是否为纯数字
- (BOOL)validateNumber {
    BOOL res = YES;
    NSCharacterSet * tempSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (NSInteger i = 0; i < self.length; i ++) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tempSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
    }
    return res;
}

#pragma makr ---字符类别方法
- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)self.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return [result lowercaseString];
}

- (NSString *)md5Salt {
    int saltInt1 = (int)(10000000 + (arc4random() % (99999999 - 10000000 + 1)));
    int saltInt2 = (int)(10000000 + (arc4random() % (99999999 - 10000000 + 1)));
#if 0
    saltInt1 = 90000001;
    saltInt2 = 90000002;
#endif
    NSString * saltStr = [NSString stringWithFormat:@"%d%d", saltInt1, saltInt2];
    NSString * password = [[self stringByAppendingString:saltStr] md5String];
    char md5Char[48];
    for (NSInteger i = 0; i < 48; i += 3) {
        md5Char[i] = [password characterAtIndex:i / 3 * 2];
        md5Char[i + 1] = [saltStr characterAtIndex:i / 3];
        md5Char[i + 2] = [password characterAtIndex:i / 3 * 2 + 1];
    }
    return [NSString stringWithFormat:@"%s", md5Char];
}

- (NSString *)SHA256 {
    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

- (BOOL)isPhoneNumber {
    // 1.创建匹配手机号的正则
    NSString *regex = @"^1([3-9][0-9])\\d{8}$";
    return [self predicateWithFormat:regex];
}

/** 判断是不是合法的用户名，支持数字、汉字、字母, 不支持特殊符号和emoji表情 */
- (BOOL)isLegitimateNickName {
    NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z0-9]+$";
    return [self predicateWithFormat:regex];;
}
/** 判断是不是合法的密码，支持数字、英文输入,英文字母支持大小写，支持特殊字符 */
- (BOOL)isLegitimatePassword {
    BOOL result = NO;
    if (self.length>12) {
        NSLog(@"密码不能大于12位");
    }else if(self.length<6){
        NSLog(@"密码不能小于6位");
    }else{
        NSString * regex1 = @"^(?=.*[0-9].*)(?=.*[a-zA-Z]).{6,12}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
        result = [pred evaluateWithObject:self];
    }
    return result;
}
/** 判断是不是合法的URL */
- (BOOL)isLegitimateURL{
    NSString *regex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    return [self predicateWithFormat:regex];
}
/** 判断是不是合法的Email */
- (BOOL)isLegitimateEmail{
    NSString *regex = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    return [self predicateWithFormat:regex];
}

- (BOOL)predicateWithFormat:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
// 获取字符串中汉字的个数
- (NSUInteger)getChineseNumCount{
    NSUInteger count = 0;
    for (int i =0; i < self.length;i++){
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            count ++;
        }
    }
    return count;
}

// NSString转NSDate
- (NSDate *)toDateWithFormat:(NSString *)format {
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    //NSString转NSDate
    NSDate * currentDate = [dateFormatter dateFromString:self];
    return currentDate;
}

/**
 生成uuid
 @param str 追加字符串
 */
+ (instancetype)generateUUIDStringByAppendingStr:(NSString *)str {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    if (str.length) {
        result = [NSString stringWithFormat:@"%@%@",result,str];
    }
    return result;
}

/**
 *  检查是否是有效字符串
 **/
- (BOOL)isExist{
    return ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0 && ![self isKindOfClass:[NSNull class]]);
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSDictionary *)getParameters {
    NSURL * url = [NSURL URLWithString:self];
    
    NSArray * urlArr = [url.absoluteString componentsSeparatedByString:@"?"];
    if (urlArr.count > 1) {
        NSArray * queryArr = [urlArr[1] componentsSeparatedByString:@"&"];
        NSMutableDictionary * parametersDic = [NSMutableDictionary dictionaryWithCapacity:1];
        for (NSInteger i = 0; i < queryArr.count; i ++) {
            NSString * item = queryArr[i];
            NSArray * itemArr = [item componentsSeparatedByString:@"="];
            if (itemArr.count > 1) {
                [parametersDic setObject:itemArr[1] forKey:itemArr[0]];
            }
        }
        return [parametersDic copy];
    }else {
        return [NSDictionary dictionary];
    }
}

- (char)mtkFirstLetterChar {
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *usedStr = [str uppercaseString];
    char char1;
    if (usedStr.length > 0) {
        char1 = [usedStr characterAtIndex:0];
    }else{
        char1 = 0;
    }
    return char1;
}

// 按照中文两个字符，英文数字一个字符计算字符数
- (NSUInteger)unicodeLengthOfString {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)time withTimeFormatter:(NSString *)timeFormatter {
    NSDate* inputDate = [self dateWithTimeIntervalInMilliSecondSince1970:time];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    
    [outputFormatter setLocale:[NSLocale currentLocale]];
    
    [outputFormatter setDateFormat:timeFormatter];
    
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+ (NSString *)getCurrentDateStringWithFormatter:(NSString *)formatter {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    NSString * currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

+ (NSString *)getCurrentTimeStamp {
    NSDate * date = [NSDate date];
    return [NSString stringWithFormat:@"%.0f", [date timeIntervalSince1970]];
}

- (NSString *)getTimeFromSeconds {
    NSInteger seconds = [self integerValue];
    NSString * hourStr = [NSString stringWithFormat:@"%02ld", seconds / 3600];
    NSString * minuteStr = [NSString stringWithFormat:@"%02ld", (seconds % 3600) / 60];
    NSString * secondsStr = [NSString stringWithFormat:@"%02ld", seconds % 60];
    return [NSString stringWithFormat:@"%@:%@:%@", hourStr, minuteStr, secondsStr];
}

+ (NSString *)getRandomString {
    char data[6];
    for (int x = 0; x < 6; x ++) {
        data[x] = (char)('A' + (arc4random_uniform(26)));
    }
    NSString * randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@", randomStr];
}

- (void)setToDictionary:(NSDictionary *)toDictionary {
    
}

- (NSDictionary *)toDictionary {
    if (![self isExist]) {
        return @{};
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        return @{};
    }
    return dictionary;
}

@end
