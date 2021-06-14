//
//  YPNavTabBar.h
//  YPNavTabBarController
//
//  Created by 巫龙 on 15/9/24.
//  Copyright (c) 2015年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /** 横线风格 */
    WLNavTabBarTypeLine = 0,
    /** 椭圆风格 */
    WLNavTabBarTypeEllipse,
    /** 箭头风格 */
    WLNavTabBarTypeArrow
} WLNavTabBarType;

typedef enum {
    /** 自适应模式 */
    WLNavTabBarStyleAdjust,
    /** 紧凑模式 */
    WLNavTabBarStyleCompact,
    /** 居中模式 */
    WLNavTabBarStyleCenter
} WLNavTabBarStyle;

@class WLNavTabBar;

@protocol YPNavTabBarDelegate <NSObject>

@optional

/** 当选项被选择时候的回调代理方法 */
- (void)itemDidSelectedWithIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index;
/** 当选项被选择时候的回调代理方法 */
- (void)progressDidSelectedWithIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index;
/** 当选项被选择时候的回调代理方法 */
- (void)progressDidNotSelectedWithIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index;

@end

@interface WLNavTabBar : UIView

/** 代理 */
@property (nonatomic, assign) id<YPNavTabBarDelegate> delegate;

/** 当前索引 */
@property (nonatomic, assign) NSInteger currentItemIndex;

/** 选项标题数组 */
@property (nonatomic, strong) NSArray* itemTitles;

/** 横条颜色 */
@property (nonatomic, strong) UIColor* navgationTabBar_lineColor;

/** 拖动比例 */
@property (nonatomic, assign) CGFloat progress;

/** 选项卡的背景颜色 */
@property (nonatomic, strong) UIColor* navgationTabBar_color;

/** 被按压的选项数组 */
@property (nonatomic, strong) NSMutableArray* items;

/** 选项标题普通状态文字的颜色 */
@property (nonatomic, strong) UIColor* navTabBar_normalTitle_color;

/** 选项标题选中状态文字的颜色 */
@property (nonatomic, strong) UIColor* navTabBar_selectedTitle_color;

/** 选项风格 */
@property (nonatomic, assign) WLNavTabBarType type;

/** 选项文字排列风格 */
@property (nonatomic, assign) WLNavTabBarStyle style;

/**
 *  刷新数据
 */
- (void)updateData;
/**
 高亮选择导航的按键(单选)
 @param btn 需要高亮的按钮
*/
-(void)highLightNavBtn:(UIButton *)btn;
/**
*  计算navbar contentsize 交给子类复写
*  @param widths 宽度
*/
- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths;

- (void)showLineWithButtonWidth:(CGFloat)width;

- (void)showEllipseWithButtonWidth:(CGFloat)width;

@end
