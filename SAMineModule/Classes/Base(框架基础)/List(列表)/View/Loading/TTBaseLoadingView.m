//
//  TTBaseLoadingView.m
//  ThroughTrafficBus
//
//  Created by 巫龙 on 2018/1/25.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "TTBaseLoadingView.h"
@interface TTBaseLoadingView()

@end
@implementation TTBaseLoadingView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleArc color:[UIColor colorWithHexString:@"324054"]];
        [self configSpinner:spinner];
        [self addSubview:spinner];
        self.spinner = spinner;
    }
    return self;
}
/**
 配置spinner的一些属性
 
 @param spinner spinner对象
 */
-(void)configSpinner:(RTSpinKitView *)spinner
{
    CGFloat size = 25;
    [spinner setHidesWhenStopped:false];
    [spinner setSize:CGSizeMake(size, size)];
    [spinner setSpinnerSize:size];
    spinner.layer.timeOffset = 1.0;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.spinner.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

-(void)startLoading
{
    if ([self superview]) {
        UIView *superView = [self superview];
        self.frame = superView.bounds;
    }
    self.spinner.hidden = false;
    [self.spinner startAnimating];
}
-(void)stopLoading
{
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
