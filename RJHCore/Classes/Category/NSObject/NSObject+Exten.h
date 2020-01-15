//
//  NSObject+Exten.h
//  QYCore
//
//  Created by KDing on 2019/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Exten)

/*
 * 属性toString 可将该实例类型转换成string
 */
@property (copy, nonatomic) NSString * toString;

@end

NS_ASSUME_NONNULL_END
