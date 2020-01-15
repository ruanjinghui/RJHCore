//
//  UIImage+Exten.h
//  GymLink
//
//  Created by 徐鹏翔 on 2017/3/17.
//  Copyright © 2017年 张艺龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (Exten)

+ (UIImage *)imageWithColor:(UIColor *)color;
/** 相机拍照的图片自动旋转90度的回正方法 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;
// 指定尺寸 进行图片压缩
+ (NSData *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;
/**
 *  拉伸图片到指定的newSize
 **/
- (UIImage *)scaleSize:(CGSize)newSize;

@end
