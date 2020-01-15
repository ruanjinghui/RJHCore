//
//  NSTimer+Exten.h
//  QYCore
//
//  Created by KDing on 2019/12/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Exten)

/**
 * 类方法, 创建一个定时器, 该方法创建的定时器不需要手动添加Timer到runloop中, 如果需要更改timer的runloop模式, 需要手动更改
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
