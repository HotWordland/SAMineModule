//
//  OCSkeletonTitleInfoDefaultCell.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/10.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "OCSkeletonTitleInfoDefaultCell.h"

@implementation OCSkeletonTitleInfoDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(CGFloat)getHeight
{
    CGFloat topSpace = 8;
    CGFloat bannerHeight = [self bannerHeight];
    CGFloat bannerBottom = topSpace + bannerHeight;
    CGFloat lineViewHeight = 8;
    CGFloat lineViewSpace = 8;
    CGFloat bannerBottomSpace = 15;
    CGFloat bottomSpace = 25;
    CGFloat bottomViewHeight = 15;
    CGFloat result = bannerBottom + bannerBottomSpace + 2*lineViewSpace + 3*lineViewHeight + bottomSpace + bottomViewHeight;
    return result;
}
- (NSArray <OCGradientLayer *>*)gradientLayers {
    if (self.titlePlaceholderView && self.subtitlePlaceholderView && self.thridPlaceholderView && self.topOnePlaceholderView && self.topSecondPlaceholderView && self.bannerHolderView && self.sepHolderView) {
        return @[self.titlePlaceholderView.gradientLayer, self.subtitlePlaceholderView.gradientLayer,self.thridPlaceholderView.gradientLayer,self.topOnePlaceholderView.gradientLayer,self.topSecondPlaceholderView.gradientLayer,self.bannerHolderView.gradientLayer,self.sepHolderView.gradientLayer];
    }
    return nil;
}

+(CGFloat)bannerWidth
{
    return 50;
}
+(CGFloat)bannerHeight
{
    return [self bannerWidth];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
