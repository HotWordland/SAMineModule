//
//  UIView+SSLoading.h
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/4/9.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHandle.h"
/**
 加载spinner
 */
@interface UIView (SSLoading)

/**
 加载业务对应的loading
 */
-(void)ssStartLoading;

/**
 停止加载业务对应的loading
 */
-(void)ssStopLoading;

/**
 加载业务对应的loading并设置颜色

 @param color 颜色
 */
-(void)ssStartLoadingWithBgColor:(UIColor *)color;

/**
 加载业务对应的loading并设置默认颜色
 */
-(void)ssStartLoadingWithDefaultBgColor;
@end
