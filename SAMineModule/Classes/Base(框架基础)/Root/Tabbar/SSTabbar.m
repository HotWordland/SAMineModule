//
//  SSTabbar.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/4.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "SSTabbar.h"

/** tabbar btn 的 高度 */
#define kTabbarBtnHeight 48

@implementation SSTabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self createCenterBarItem];
    }
    return self;
}
/**
 创建tabbar中间的item
 */
-(void)createCenterBarItem
{
    CGFloat btnSize = kTabbarBtnHeight;
//    CCLottiePartView *centerBarBtn = [[CCLottiePartView alloc] initWithFrame:CGRectMake(0, 0, btnSize, btnSize) animationName:@"lf30_editor_totvbxfa"];
//    [centerBarBtn setTitle:@" " forState:UIControlStateNormal];
//    [centerBarBtn setBackgroundImage:[UIImage imageNamed:@"tabbarCenter"] forState:UIControlStateNormal];
//    centerBarBtn.adjustsImageWhenHighlighted = NO;
//    [centerBarBtn addTarget:self action:@selector(centerBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    centerBarBtn.layer.cornerRadius = centerBarBtn.width * 0.5;
//    centerBarBtn.layer.masksToBounds = YES;
//    [self addSubview:centerBarBtn];
//    self.centerBarBtn = centerBarBtn;
//    UITapGestureRecognizer *tapCenterBtn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCenterBtn:)];
//    self.centerBarBtn.userInteractionEnabled = true;
//    [centerBarBtn addGestureRecognizer:tapCenterBtn];
//    self.lblCenterBar = ({
//        UILabel *lblCenterBar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//        [lblCenterBar setNumberOfLines:0];
//        [lblCenterBar setFont:[UIFont systemFontOfSize:10]];
//        UIColor *fontColor = RGBACOLOR(99, 99, 99, 1);
//        [lblCenterBar setTextColor:fontColor];
//        [lblCenterBar setTextAlignment:NSTextAlignmentCenter];
//        [lblCenterBar setText:@"山城直播"];
//        [lblCenterBar sizeToFit];
//        [self addSubview:lblCenterBar];
//        lblCenterBar;
//    });
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
/**
 根据title隐藏tabbar btn
 @params title 隐藏的按钮标题
 */
-(void)hiddenTabbarBtnWithTitle:(NSString *)title
{
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            for (UIView *tchild in child.subviews) {
                Class tBtnLabelClass = NSClassFromString(@"UITabBarButtonLabel");
                if ([tchild isKindOfClass:tBtnLabelClass]) {
                    UILabel *tchildLabel = (UILabel *)tchild;
                    if ([tchildLabel.text isEqualToString:title]){
                        child.hidden = true;
                    }
                }
            }
        }
    }
}
/** 隐藏所有的tabbar button */
-(void)hiddenAllTabbarButton
{
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.hidden = true;
        }
    }
}

@end
