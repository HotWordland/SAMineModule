//
//  TTRefreshFooter.m
//  ThroughTrafficBus
//
//  Created by 情热大陆 on 2018/1/25.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "TTRefreshFooter.h"
#import "RTSpinKitView.h"

@interface TTRefreshFooter()
@property (strong, nonatomic) RTSpinKitView *spinner;

@end

@implementation TTRefreshFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyle9CubeGrid color:MAINTHEMECOLOR];
    [self configSpinner:spinner];
    [self addSubview:spinner];
    self.spinner = spinner;
    self.stateLabel.textColor = [UIColor lightGrayColor];
}

/**
 配置spinner的一些属性
 
 @param spinner spinner对象
 */
-(void)configSpinner:(RTSpinKitView *)spinner
{
    CGFloat size = 23;
    [spinner setHidesWhenStopped:false];
    [spinner setSize:CGSizeMake(size, size)];
    [spinner setSpinnerSize:size];
    spinner.layer.timeOffset = 1.0;
    
}
#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.spinner.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    
    // 根据状态做事情
    if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        [self.spinner stopAnimating];
        self.spinner.hidden = true;
        self.stateLabel.hidden = false;
        
    } else if (state == MJRefreshStateRefreshing) {
        [self.spinner startAnimating];
        self.spinner.hidden = false;
        self.stateLabel.hidden = true;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
