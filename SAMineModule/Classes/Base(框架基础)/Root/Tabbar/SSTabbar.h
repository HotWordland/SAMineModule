//
//  SSTabbar.h
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/4.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CenterBarBtnClickBlock)();
@interface SSTabbar : UITabBar
/** centerBarBtnBlock */
@property (nonatomic, copy) CenterBarBtnClickBlock centerBarBtnClickBlock;
/** centerBarButton */
@property (strong, nonatomic) UIView *centerBarBtn;
@property (strong, nonatomic) UILabel *lblCenterBar;
/**
 根据title隐藏tabbar btn
 @params title 隐藏的按钮标题
 */
-(void)hiddenTabbarBtnWithTitle:(NSString *)title;
/**
 创建tabbar中间的item
 */
-(void)createCenterBarItem;

/** 隐藏所有的tabbar button */
-(void)hiddenAllTabbarButton;

@end
