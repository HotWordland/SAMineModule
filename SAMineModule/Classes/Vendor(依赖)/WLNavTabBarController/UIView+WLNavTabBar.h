//
//  UIView+YPNavTabBar.h
//  YPNavTabBarController
//
//  Created by 巫龙 on 15/9/24.
//  Copyright (c) 2015年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLNavTabBar)

// frame
@property (nonatomic, assign) CGFloat wl_x;
@property (nonatomic, assign) CGFloat wl_y;
@property (nonatomic, assign) CGFloat wl_width;
@property (nonatomic, assign) CGFloat wl_height;
@property (nonatomic, assign) CGSize wl_size;
@property (nonatomic, assign) CGPoint wl_origin;
// center
@property (nonatomic, assign) CGFloat wl_centerX;
@property (nonatomic, assign) CGFloat wl_centerY;

@end
