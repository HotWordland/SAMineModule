//
//  BYBaseShowModalHandle.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2019/4/10.
//  Copyright © 2019 巫龙. All rights reserved.
//

#import "BYBaseShowModalHandle.h"
@interface BYBaseShowModalHandle()
// bottom space
@property (strong, nonatomic) NSLayoutConstraint *bottomContraint;

@end

@implementation BYBaseShowModalHandle
// init function
-(instancetype)initWithToolView:(TTBaseView *)toolView Controller:(UIViewController *)controller{
    self = [super init];
    if (self) {
        self.postToolView = toolView;
        self.controller = controller;
        [self addObserverForNoti];
    }
    return self;
}
//give to subclass add noti
-(void)addObserverForNoti
{
    
}
-(void)removeObserverForNoti
{
    
}
-(void)dealloc{
    DLog(@"%@ - dealloc",NSStringFromClass([self class]));
    [self removeObserverForNoti];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.controller.view.width, self.controller.view.height)];
        _bgView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBg:)];
        [_bgView addGestureRecognizer:tap];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.0;
    }
    return _bgView;
}
// click bg to dismiss view
-(void)clickBg:(UITapGestureRecognizer *)tap{
    [self.controller.view endEditing:true];
    [self dismiss];
}
// load
-(void)loadPostToolView
{
    PREPCONSTRAINTS(self.postToolView);
    [self.controller.view addSubview:self.postToolView];
    CONSTRAIN_SIZE(self.postToolView, YYScreenSize().width, [self getToolViewHeight]);
    ALIGN_LEFT(self.postToolView, 0);
    ALIGN_RIGHT(self.postToolView, 0);
    NSLayoutConstraint *bottomConstraint = CONSTRAINT_ALIGNING_BOTTOM(self.postToolView, -([self getToolViewHeight] + 10));
    [self.controller.view addConstraint:bottomConstraint];
    self.bottomContraint = bottomConstraint;
}
-(CGFloat)getToolViewHeight{
   return [[self.postToolView class] get_height];
}
-(void)show
{
    self.bgView.alpha = 0.0;
    [self.controller.view addSubview:self.bgView];
    [self.controller.view bringSubviewToFront:self.postToolView];
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.bottomContraint.constant = 0;
        self.bgView.alpha = 0.7;
        [self.controller.view layoutIfNeeded];
    } completion:nil];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.bottomContraint.constant = ([self getToolViewHeight] + 10);
        self.bgView.alpha = 0.0;
        [self.controller.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.bgView removeFromSuperview];
        }
    }];
}

@end
