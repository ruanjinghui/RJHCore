//
//  NSTimer+Exten.m
//  QYCore
//
//  Created by KDing on 2019/12/3.
//

#import "NSTimer+Exten.h"

@implementation NSTimer (Exten)

+ (void)qy_ExectBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(qy_ExectBlock:) userInfo:[block copy] repeats:repeats];
}

@end
