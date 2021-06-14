//
//  BYLoadingView.h
//  BYLottery
//
//  Created by 情热大陆 on 2017/11/19.
//  Copyright © 2017年 Lon. All rights reserved.
//

#import "TTBaseView.h"
#import <SpinKit/RTSpinKitView.h>

@interface BYLoadingView : TTBaseView
@property (nonatomic,strong) RTSpinKitView *spinner;
@property (nonatomic,strong) UILabel *lbl_title;

/**
 开始加载

 @param container_view 加载容器
 */
-(void)showAtView:(UIView *)container_view;

/**
 初始化并配置一些内容

 @param frame 尺寸
 @param type_name loading类型
 @param title 标题描述
 @return
 */
-(instancetype)initWithFrame:(CGRect)frame type:(NSString *)type_name title:(NSString *)title;

/**
 设置描述

 @param title 描述内容
 */
-(void)setTitle:(NSString *)title;

/**
 停止加载
 */
-(void)dismiss;
@end
