//
//  TTBasePopView.m
//  Travel-Tp
//
//  Created by Ryzen on 2019/11/12.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "TTBasePopView.h"
#define kBackgroundViewShowAlpha 0.6

@implementation TTBasePopView
/// 遮罩view
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = kBackgroundViewShowAlpha;
        _backgroundView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackgroundView:)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}
/**
 关闭费用明细view
 */
-(void)clickBackgroundView:(UITapGestureRecognizer *)tap{
    [self openDetailView:false withView:nil];
}
/**
 是否打开view
 
 @param flag 是否打开或者关闭
 */
-(void)openDetailView:(BOOL)flag withView:(nullable UIView *)superView{
    if (!flag) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        return;
    }
    if (superView) {
        PREPCONSTRAINTS(self);
        [superView addSubview:self];
        ALIGN_LEFT(self, 0);
        ALIGN_RIGHT(self, 0);
        NSLayoutConstraint *abttom = nil;
        if (@available(iOS 11.0, *)) {
            abttom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem:superView.safeAreaLayoutGuide attribute: NSLayoutAttributeBottom multiplier: 1.0f constant: 100];
        }else{
            abttom = CONSTRAINT_ALIGNING_BOTTOM(self, -100);
        }
        [superView addConstraint:abttom];
//        self.calendarContainerHeightCt.constant = kDefaultCalendarHeight;
        [superView layoutIfNeeded];
        [superView insertSubview:self.backgroundView belowSubview:self];
        self.backgroundView.alpha = 0;
        self.alpha = 0;
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:8 options:UIViewAnimationOptionCurveEaseIn animations:^{
            abttom.constant = 0;
            self.alpha = 1.0;
            self.backgroundView.alpha = kBackgroundViewShowAlpha;
            [self.superview layoutIfNeeded];
        } completion:nil];

    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.superview){
        self.backgroundView.size = CGSizeMake(self.superview.width, self.superview.height);
        self.backgroundView.left = 0;
        self.backgroundView.top = 0;
    }
}

@end
