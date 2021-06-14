//
//  BYLoadingView.m
//  BYLottery
//
//  Created by 情热大陆 on 2017/11/19.
//  Copyright © 2017年 Lon. All rights reserved.
//

#import "BYLoadingView.h"

@implementation BYLoadingView
-(instancetype)initWithFrame:(CGRect)frame type:(NSString *)type_name title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.spinner = ({
            RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleArc color:[UIColor colorWithHexString:@"349AEF"]];
            //        [smallActivityIndicatorView setCenter:spinner.center];
            CGFloat size = 25;
            [spinner setHidesWhenStopped:false];
            [spinner setSize:CGSizeMake(size, size)];
            [spinner setSpinnerSize:size];
            [self addSubview:spinner];
            spinner;
        });
        CGFloat her_padding = [self getLayoutinfoItem:@"her_padding"];
        CGFloat title_width = frame.size.width - 2*her_padding;
        self.lbl_title = ({
            UILabel *lbl_position = [[UILabel alloc]initWithFrame:CGRectMake(her_padding, 0, title_width, 30)];
            [lbl_position setNumberOfLines:0];
            [lbl_position setFont:[UIFont systemFontOfSize:14]];
            UIColor *font_color = RGBACOLOR(160, 160, 160, 1);
            [lbl_position setTextColor:font_color];
            [lbl_position setTextAlignment:NSTextAlignmentCenter];
            [lbl_position setText:title];
            [lbl_position sizeToFit];
            [self addSubview:lbl_position];
            lbl_position;
        });

        [self setBackgroundColor:RGBACOLOR(245, 245, 245, 1)];
    }
    return self;
}
-(NSDictionary *)layinfo{
    return  @{
              @"her_padding":[NSNumber numberWithFloat:10],
              @"ver_padding":[NSNumber numberWithFloat:10],
              
              };
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat ver_padding = [self getLayoutinfoItem:@"ver_padding"];
    CGFloat her_padding = [self getLayoutinfoItem:@"her_padding"];
    [self.spinner setCenterX:self.width/2];
    [self.spinner setCenterY:self.height/2-10];
    CGFloat title_width = self.size.width - 2*her_padding;
    [self.lbl_title setWidth:title_width];
    [self.lbl_title setCenterX:self.width/2];
    [self.lbl_title setTop:self.spinner.bottom+ver_padding];    
}

-(void)showAtView:(UIView *)container_view{
    [container_view addSubview:self];
    [self.spinner startAnimating];
}
-(void)dismiss{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{        
        [UIView animateWithDuration:0.3 animations:^{
            [self setAlpha:0.0];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.spinner stopAnimating];
                [self removeFromSuperview];
            }
        }];
    });
}
-(void)setTitle:(NSString *)title{
    [self.lbl_title setText:title];
    CGFloat her_padding = [self getLayoutinfoItem:@"her_padding"];
    CGFloat title_width = self.size.width - 2*her_padding;
    [self.lbl_title setWidth:title_width];
    [self.lbl_title sizeToFit];
}
@end
