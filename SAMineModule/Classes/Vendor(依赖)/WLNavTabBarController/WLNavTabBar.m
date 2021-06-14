//
//  YPNavTabBar.m
//  YPNavTabBarController
//
//  Created by 巫龙 on 15/9/24.
//  Copyright (c) 2015年 巫龙. All rights reserved.
//

#import "WLNavTabBar.h"
#import "WLNavTabBarControllerConst.h"
/**
 普通的tabbar(按钮布局)
*/
@interface WLNavTabBar()

/** 存储所有选项标题长度的数组 */
@property (nonatomic, strong) NSArray *itemsWidth;

/** 所有的选项标题都在这个ScrollView上 */
@property (nonatomic, weak) UIScrollView *navgationTabBar;

/** 横条 */
@property (nonatomic, weak) UIView *line;

/** 椭圆条 */
@property (nonatomic, weak) UIView *ellipse;

@end

@implementation WLNavTabBar


#pragma mark - lazy -

- (UIScrollView *)navgationTabBar
{
    if (_navgationTabBar == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = WLClearColor;
        [self addSubview:scrollView];
        self.navgationTabBar = scrollView;
    }
    return _navgationTabBar;
}


- (UIView *)ellipse
{
    if (_ellipse == nil) {
        UIView *view = [[UIView alloc] init];
        view.layer.cornerRadius = 10;
        view.backgroundColor = WLColor_RGBA(200, 200, 200, 0.3);
        [self.navgationTabBar addSubview:view];
        self.ellipse = view;
        self.ellipse.hidden = YES;
    }
    return _ellipse;
}


- (UIView *)line
{
    if (_line == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = WLColor_RGBA(20.0f, 80.0f, 200.0f, 0.7f);
        [self.navgationTabBar addSubview:view];
        self.line = view;
        self.line.hidden = NO;
    }
    return _line;
}

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

#pragma mark - Life Cycle -
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 准备工作
        [self prepare];
    }
    return self;
}

- (void)prepare
{
    self.navgationTabBar.frame = CGRectMake(0, 0, WLScreenW, self.frame.size.height);
}

#pragma mark - 公共方法 -
- (void)updateData
{
    // 如果没有值直接返回
    if (!self.itemTitles.count) return;
    if (self.itemTitles.count <= 4) { // 当按钮小于等于4个的时候并列排布
        CGFloat btnWidth = WLScreenW / self.itemTitles.count;
        self.navgationTabBar.contentSize = CGSizeMake(btnWidth * self.itemTitles.count, 0);
        [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:[self getButtonsWidthWithTitles:self.itemTitles]];
    } else { // 对于4个的时候紧凑排布
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:[self getButtonsWidthWithTitles:self.itemTitles]];
        self.navgationTabBar.contentSize = CGSizeMake(contentWidth, 0);
    }
}

#pragma mark - 私有方法 -
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles
{
    NSMutableArray *widths = [NSMutableArray arrayWithCapacity:titles.count];

    if (titles.count <= 4) { // 当按钮小于等于4个的时候并列排布
        for (int i = 0; i < titles.count; i++) {
            NSNumber *width = [NSNumber numberWithFloat:self.navgationTabBar.contentSize.width / titles.count];
            NSLog(@"%@",width);
            [widths addObject:width];
        }
    } else { // 当按钮多于4个的时候紧凑排布
        for (NSString *title in titles)
        {
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
            attributes[NSFontAttributeName] = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            
            size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            
            NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
            [widths addObject:width];
        }
    }
    // 存储所有按钮的长度
    self.itemsWidth = widths;
    
    return widths;
}
/// 添加额外的btn的配置 交给子类实现
-(void)extraConfigButtonsAppearence:(UIButton *)btn
{
    
}
/// 交给子类复写
/// @param widths 宽度
- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = 0;
    for (NSInteger index = 0; index < self.itemTitles.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, 0, [widths[index] floatValue], self.frame.size.height);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self extraConfigButtonsAppearence:button];
        [_navgationTabBar addSubview:button];
        [self.items addObject:button];
        buttonX += [widths[index] floatValue];
        if (index == 0) {
            button.selected = YES;
        }
    }
    
    [self showLineWithButtonWidth:[widths[0] floatValue]];
    
    [self showEllipseWithButtonWidth:[widths[0] floatValue]];
    
    
    return buttonX;
}
/**
 高亮选择导航的按键(单选)
 @param btn 需要高亮的按钮
*/
-(void)highLightNavBtn:(UIButton *)btn
{
    btn.selected = YES;
    NSUInteger index = [self.items indexOfObject:btn];
    for (int i = 0; i < (int)self.items.count; i++) {
        UIButton* btn = self.items[i];
        if (i != index) {
            btn.selected = NO;
        }
    }
}
/**
 点击按钮切换
 @param button 点击的按钮
*/
- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [self.items indexOfObject:button];
    [self highLightNavBtn:button];
    if ([_delegate respondsToSelector:@selector(itemDidSelectedWithIndex:index:)]) {
        [_delegate itemDidSelectedWithIndex:self index:index];
    }
}


- (void)showLineWithButtonWidth:(CGFloat)width
{
    self.line.frame = CGRectMake(2.0f, self.frame.size.height - 3.0f, width - 4.0f, 3.0f);
}

- (void)showEllipseWithButtonWidth:(CGFloat)width
{
    self.ellipse.frame = CGRectMake(2.0f, 8.0f, width - 4.0f, self.frame.size.height - 16.0f);
}


#pragma mark - setter -

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _currentItemIndex = (int)progress;
    if (_currentItemIndex > [_items count] - 1) {
        return;
    }
    
    UIButton *oldBtn;
    
    if (_currentItemIndex > 0) {
        oldBtn = _items.count == 0 ? [UIButton new] : _items[_currentItemIndex - 1];
    }
    
    
    UIButton *button = _items.count == 0 ? [UIButton new] : _items[_currentItemIndex];
    
    CGFloat flag = WLScreenW;
    
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count] - 1)
        {
            offsetX = offsetX + 40.0f;
        }
        
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGFloat lineX = 0;
        
        if (oldBtn) { // 如果有上一个按钮
            lineX = button.frame.origin.x + oldBtn.frame.size.width * (self->_progress - (int)self->_progress);
        } else { // 如果没有上一个按钮
            lineX = button.frame.size.width * (self->_progress - (int)self->_progress);
        }
        
        if ((self->_progress - (int)self->_progress) == 0) {
            lineX = button.frame.origin.x;
            // 回调代理方法
//            if ([_delegate respondsToSelector:@selector(itemDidSelectedWithIndex:index:)]) {
//                [self.delegate itemDidSelectedWithIndex:self index:_progress];
//            }
            UIButton *button = [self.items objectAtIndex:floor(self->_progress)];
            [self highLightNavBtn:button];
            if ([self->_delegate respondsToSelector:@selector(progressDidSelectedWithIndex:index:)]) {
                [self.delegate progressDidSelectedWithIndex:self index:self->_progress];

            }
        }else{
            if ([self->_delegate respondsToSelector:@selector(progressDidNotSelectedWithIndex:index:)]) {
                [self.delegate progressDidNotSelectedWithIndex:self index:self->_progress];
            }
        }
        CGFloat lineY = self->_line.frame.origin.y;
        CGFloat lineW = [self->_itemsWidth[self->_currentItemIndex] floatValue] - 4.0f;
        CGFloat lineH = self->_line.frame.size.height;
        self.line.frame = CGRectMake(lineX + 2.0f, lineY, lineW, lineH);
        self.ellipse.frame = CGRectMake(self.line.frame.origin.x, self.ellipse.frame.origin.y, self.line.frame.size.width, self.ellipse.frame.size.height);
        
    }];
}

- (void)setNavgationTabBar_color:(UIColor *)navgationTabBar_color
{
    _navgationTabBar_color = navgationTabBar_color;
    
    self.navgationTabBar.backgroundColor = navgationTabBar_color;
}

- (void)setNavgationTabBar_lineColor:(UIColor *)navgationTabBar_lineColor
{
    _navgationTabBar_lineColor = navgationTabBar_lineColor;
    
    self.line.backgroundColor = navgationTabBar_lineColor;
}

- (void)setNavTabBar_normalTitle_color:(UIColor *)navTabBar_normalTitle_color
{
    _navTabBar_normalTitle_color = navTabBar_normalTitle_color;
    
    
    for (UIButton *btn in self.items) {
        [btn setTitleColor:navTabBar_normalTitle_color forState:UIControlStateNormal];
    }
}

- (void)setNavTabBar_selectedTitle_color:(UIColor *)navTabBar_selectedTitle_color
{
    _navTabBar_selectedTitle_color = navTabBar_selectedTitle_color;
    
    for (UIButton *btn in self.items) {
        [btn setTitleColor:navTabBar_selectedTitle_color forState:UIControlStateSelected];
    }
}

- (void)setType:(WLNavTabBarType)type
{
    _type = type;
    
    switch (type) {
        case WLNavTabBarTypeLine:
            self.line.hidden = NO;
            self.ellipse.hidden = YES;
            break;
        case WLNavTabBarTypeEllipse:
            self.line.hidden = YES;
            self.ellipse.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)setStyle:(WLNavTabBarStyle)style
{
    _style = style;
}





@end





















