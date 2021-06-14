//
//  ZYBannerCell.m
//
//  Created by 张志延 on 15/10/17.
//  Copyright (c) 2015年 tongbu. All rights reserved.
//

#import "ZYBannerCell.h"

@implementation ZYBannerCell
@synthesize itemView = _itemView;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.itemView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.frame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height);
}

- (UIView *)itemView
{
    if (!_itemView) {
        _itemView = [[UIView alloc] init];
    }
    return _itemView;
}

- (void)setItemView:(UIView *)itemView
{
    if (_itemView) {
        [_itemView removeFromSuperview];
    }
    
    _itemView = itemView;
    
    [self addSubview:_itemView];
}

@end
