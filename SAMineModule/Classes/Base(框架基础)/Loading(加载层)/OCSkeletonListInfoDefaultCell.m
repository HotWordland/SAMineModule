//
//  OCSkeletonListInfoDefaultCell.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/10.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "OCSkeletonListInfoDefaultCell.h"

@implementation OCSkeletonListInfoDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSArray <OCGradientLayer *>*)gradientLayers {
    if (self.titlePlaceholderView && self.subtitlePlaceholderView) {
        return @[self.titlePlaceholderView.gradientLayer, self.subtitlePlaceholderView.gradientLayer];
    }
    return nil;
}

+(CGFloat)getHeight
{
    return 70;
}

@end
