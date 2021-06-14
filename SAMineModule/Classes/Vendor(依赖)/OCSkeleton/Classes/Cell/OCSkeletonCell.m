//
//  OCSkeletonCell.m
//  OCSkeleton_Example
//
//  Created by Mayqiyue on 05/03/2018.
//  Copyright © 2018 mayqiyue. All rights reserved.
//

#import "OCSkeletonCell.h"

@implementation OCSkeletonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imagePlaceholderView.layer.cornerRadius = self.imagePlaceholderView.bounds.size.width/2.0f;
}

- (NSArray <OCGradientLayer *>*)gradientLayers {
    if (self.titlePlaceholderView && self.subtitlePlaceholderView && self.imagePlaceholderView) {
        return @[self.titlePlaceholderView.gradientLayer, self.subtitlePlaceholderView.gradientLayer,self.imagePlaceholderView.gradientLayer];
    }
    return nil;
}
+(UIColor *)generateBrightenedWithRaw:(UIColor *)raw Factor:(CGFloat)factor
{
    return brightened(raw, factor);
}
//渐变
UIColor *brightened(UIColor *raw, CGFloat factor) {
    CGFloat h,s,b,a;
    [raw getHue:&h saturation:&s brightness:&b alpha:&a];
    return [UIColor colorWithHue:h saturation:s brightness:b*factor alpha:a];
}

@end
