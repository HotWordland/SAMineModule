//
//  OCSkeletonCollectDefaultCell.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "OCSkeletonCollectDefaultCell.h"

@implementation OCSkeletonCollectDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addShadowViewStyleDefault:self.bgView];
    for (OCGradientLayer *v in self.gradientLayers) {
        [self addLineGradientCornerRadius:v];
    }
}
/**
 添加阴影默认style
 
 @param view 添加阴影的view
 */
-(void)addShadowViewStyleDefault:(UIView *)view
{
    view.layer.cornerRadius = 2.f;
    view.layer.shadowColor = RGBACOLOR(231, 231, 231,1).CGColor;
    view.layer.shadowOpacity = 0.8f;
    view.layer.shadowRadius = 3.f;
    view.layer.shadowOffset = CGSizeMake(1,0);
}

/**
 添加GradientLayer的圆角(无效测试中)

 @param layer layer
 */
-(void)addLineGradientCornerRadius:(OCGradientLayer *)layer
{
     layer.cornerRadius = 3.f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imagePlaceholderView.layer.cornerRadius = self.imagePlaceholderView.bounds.size.width/2.0f;
}
- (NSArray <OCGradientLayer *>*)gradientLayers {
    if (self.titlePlaceholderView && self.subtitlePlaceholderView) {
        return @[self.titlePlaceholderView.gradientLayer, self.subtitlePlaceholderView.gradientLayer];
    }
    return nil;
}

@end
