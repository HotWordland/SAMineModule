//
//  YPNavTabBarController.h
//  YPNavTabBarController
//
//  Created by 巫龙 on 15/9/24.
//  Copyright (c) 2015年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNavTabBar.h"

@interface UIViewController()

@property (nonatomic, strong, readwrite) NSNumber *curInSegmentIndex;

@end

@interface WLNavTabBarController : UIViewController
/** 选项标题数组 */
@property (nonatomic, strong) NSMutableArray* titles;
/** 滚动主视图 */
@property (nonatomic, weak) UIScrollView* mainView;
/** 子控制器 */
@property (nonatomic, strong) NSArray* subViewControllers;
/** 选项条顶端距离父视图顶端的距离 */
@property (nonatomic, assign) CGFloat navTabBar_Y;

/** 内容视图的高度 */
@property (nonatomic, assign) CGFloat contentViewH;

/** 设置风格 */
@property (nonatomic, assign) WLNavTabBarType navTabBar_type;

/** 设置选项排列风格 */
@property (nonatomic, assign) WLNavTabBarStyle navTabBar_style;

/** 设置选项卡的背景颜色 */
@property (nonatomic, strong) UIColor* navTabBar_color;

/** 选项条横条的颜色 */
@property (nonatomic, strong) UIColor* navTabBarLine_color;

/** 选项标题普通状态文字的颜色 */
@property (nonatomic, strong) UIColor* navTabBar_normalTitle_color;

/** 选项标题选中状态文字的颜色 */
@property (nonatomic, strong) UIColor* navTabBar_selectedTitle_color;

/** 索引(如果使用请在所有属性赋值之前调用) */
@property (nonatomic, assign) NSInteger currentIndex;
/** 选线条 */
@property (nonatomic, weak) WLNavTabBar* navTabBar;
/** 开始拖动时的偏移量 */
@property (nonatomic, assign) CGFloat startContentOffsetX;
/**
 这里仅仅是扩展一下 供子类好重写
 
 @param controller 子vc
 */
-(void)scrollMonitorAddController:(UIViewController *)controller;

/**
 刷新offset
 */
-(void)refreshOffsetHandle;
/**
 获取当前显示的子Controller的index

 @return NSInteger
 */
-(NSInteger)getCurrentScrollIndex;
/** 构造方法 */
- (instancetype)initWithParentViewController:(UIViewController*)parentViewController;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

@interface UIViewController (YPNavTabBarControllerItem)

@property (nonatomic, strong, readonly) WLNavTabBarController* navTabBarController;

@end

