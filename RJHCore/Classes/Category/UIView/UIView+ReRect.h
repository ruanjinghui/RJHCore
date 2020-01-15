//
//  UIView+ReRect.h
//  GymLink_new
//
//  Created by 张艺龙 on 2017/5/24.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ReRect)

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat right;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;

@end
