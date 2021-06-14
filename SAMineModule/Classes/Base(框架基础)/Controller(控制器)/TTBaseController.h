//
//  TTBaseController.h
//  Travel-Tp
//
//  Created by Curse Tom on 2019/12/7.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCPopup.h"
#import <STPopup/STPopup.h>
#import "TTSTPopupController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseController : UIViewController
/**
 字符最大limit(一些需要输入字符的情况)
 */
@property (strong, nonatomic) NSNumber *maxStringCount;
/**
 安全区高度(兼容11以下)
 */
@property (assign, nonatomic) CGFloat safeAreaHeight;

/**
 弹出层对象
 */
@property (nonatomic,strong) KLCPopup* popup;
/**
 事件block
 */
@property (copy, nonatomic) void(^emitEvent)(id event,id param);
/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */

-(void)eventEmit:(id)event param:(id)param;

/**
 开始加载状态
 */
-(void)startLoading;

/**
 隐藏加载状态
 */
-(void)dismissLoading;

/**
 显示遮罩view

 @param belowView 遮罩层上层的view
 */
-(void)showOverlayViewWithBlowView:(UIView *)belowView;

/**
 去掉遮罩层
 */
-(void)dismissOverlayView;
/**
 弹出视图
 
 @param v 父视图
 @param size 显示的size
 @param flag 是否可以点击退出
 */
-(void)showInView:(UIView *)v size:(CGSize)size dismissTouch:(BOOL)flag;
/**
 配置一些加载项
 */
-(void)baseConfig;
/**
 生成居中的layout popup弹窗
 @param v 居中的视图
 @param complete 回调
*/
-(void)generateCenterPopupLayoutWithView:(UIView *)v complete:(void(^)(KLCPopupLayout layout, KLCPopup* popup))complete;
/**
 生成从底部弹出的layout popup弹窗
 @param v 底部的视图
 @param complete 回调
*/
-(void)generatePopupFromBottomWithView:(UIView *)v complete:(void(^)(KLCPopupLayout layout, KLCPopup* popup))complete;

/** 获取顶部navgationBar包含状态栏的高度 */
-(CGFloat)getNavBarHeightIncludeStatusBar;
/**
 生成跳转STPopupController
*/
-(TTSTPopupController *)generatePopControllerWidthRootController:(UIViewController *)rootController;
/** 交给子类复写 */
-(void)click_back:(UIButton *)btn;
/** nullview视图点击事件 交给子类实现*/
-(void)clickReloadDataInControllerView:(UITapGestureRecognizer *)tap;
/** 点击popup 背景 */
-(void)backgroundSTPopViewDidTap:(UITapGestureRecognizer *)tap;

@end

NS_ASSUME_NONNULL_END
