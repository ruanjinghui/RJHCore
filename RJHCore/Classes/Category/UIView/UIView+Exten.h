//
//  UIView+Exten.h
//  QYCore
//
//  Created by KDing on 2019/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Exten)

/**
 * 当前view的所属控制器
 */
@property (nullable, nonatomic, readonly) UIViewController * viewController;

@end

NS_ASSUME_NONNULL_END
