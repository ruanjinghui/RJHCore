//
//  UIViewController+Animation.m
//  Bubbling
//
//  Created by 张艺龙 on 2017/12/21.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import "UIViewController+Animation.h"

@implementation UIViewController (Animation)

- (void)crossDissolvePresent:(void (^)(void))animate {
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    typedef void (^Animation)(void);
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        if (animate) {
            animate();
        }
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:self.view
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

@end
