//
//  UIViewController+MPExtend.m
//  Bubbling
//
//  Created by aladin on 2018/8/15.
//  Copyright © 2018年 阿拉丁. All rights reserved.
//

#import "UIViewController+MPExtend.h"

@implementation UIViewController (MPExtend)

+ (UIViewController *)currentViewController {
    UIViewController * viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController&&![vc.presentedViewController isKindOfClass:NSClassFromString(@"UIAlertController")]) {
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        return vc;
    }
}

@end
