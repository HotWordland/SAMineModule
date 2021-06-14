//
//  TTBasePopView.h
//  Travel-Tp
//  浮动弹出层View
//  Created by Ryzen on 2019/11/12.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseView.h"
NS_ASSUME_NONNULL_BEGIN
//浮动弹出层 自定义view继承即可弹出
@interface TTBasePopView : TTBaseView
/**
 背景view
 */
@property (strong, nonatomic) UIView *backgroundView;
/**
 是否打开view
 
 @param flag 是否打开或者关闭
 */
-(void)openDetailView:(BOOL)flag withView:(nullable UIView *)superView;
@end

NS_ASSUME_NONNULL_END
