//
//  UIView+Exten.m
//  QYCore
//
//  Created by KDing on 2019/12/3.
//

#import "UIView+Exten.h"

@implementation UIView (Exten)

- (UIViewController *)viewController {
    for (UIView * view = self; view; view = view.superview) {
        UIResponder * nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
