//
//  UIViewController+Animation.h
//  Bubbling
//
//  Created by 张艺龙 on 2017/12/21.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Animation)

- (void)crossDissolvePresent:(void (^)(void))animate;

@end
