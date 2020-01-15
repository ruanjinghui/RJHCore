//
//  UIViewController+MPExtend.h
//  Bubbling
//
//  Created by aladin on 2018/8/15.
//  Copyright © 2018年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MPExtend)

/**
 获取当前屏幕显示的viewcontroller(不包含tabbar和nav)
 */
+ (UIViewController *)currentViewController;

@end
