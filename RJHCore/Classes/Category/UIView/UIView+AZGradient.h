//
//  UIView+AZGradient.h
//  AZCategory
//
//  Created by Alfred Zhang on 2017/6/29.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AZGradient)

/* The array of CGColorRef objects defining the color of each gradient
 * stop. Defaults to nil. Animatable. */
/* 渐变色值组 如果只有一个颜色 设置无效 */
@property(nullable, copy) NSArray *az_colors;

/* An optional array of NSNumber objects defining the location of each
 * gradient stop as a value in the range [0,1]. The values must be
 * monotonically increasing. If a nil array is given, the stops are
 * assumed to spread uniformly across the [0,1] range. When rendered,
 * the colors are mapped to the output colorspace before being
 * interpolated. Defaults to nil. Animatable. */
/* 颜色的渐变范围 【0~1之间】与 az_colors对应，
 * eg 1:az_colors    @[blue,red]
 *      az_locations @[0.3,0.5] 【分3段j区间 0~0.3,0.3~0.5,0.5~1】
 *      0~0.3为纯 blue 0.3~0.5为blue向red渐变 0.5~1为纯red
 *      当颜色多余区间的时候 区间外的颜色不显示
 * eg 2:az_colors       @[blue,red,yellow]
        az_locations    @[0.3]
        那么 在0~0.3区间为blue 0.3~1区间为blue向red渐变 黄色将不显示
 */
@property(nullable, copy) NSArray<NSNumber *> *az_locations;

/* The start and end points of the gradient when drawn into the layer's
 * coordinate space. The start point corresponds to the first gradient
 * stop, the end point to the last gradient stop. Both points are
 * defined in a unit coordinate space that is then mapped to the
 * layer's bounds rectangle when drawn. (I.e. [0,0] is the bottom-left
 * corner of the layer, [1,1] is the top-right corner.) The default values
 * are [.5,0] and [.5,1] respectively. Both are animatable. */

/**
 起始点终止点 相对于视图的点位
 eg1: 水平横向 start:(0,0) -> end:(1,0)
 eg2: 垂直纵向 start:(0,0) -> end:(0,1)
 eg3: start:(0.5,0) -> end:(1,0) 水平方向 0~0.5区间纯色 0.5~1渐变
 */
@property CGPoint az_startPoint;
@property CGPoint az_endPoint;

/**
 创建渐变色背景的视图 并返回
 */
+ (UIView *_Nullable)az_gradientViewWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 给已有视图设置背景色
*/
- (void)az_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (void)az_setMaskGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
