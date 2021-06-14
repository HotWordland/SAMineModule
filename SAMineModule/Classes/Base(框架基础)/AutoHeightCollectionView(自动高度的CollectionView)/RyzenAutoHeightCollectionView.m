//
//  RyzenAutoHeightCollectionView.m
//  sa
//
//  Created by Curse Tom on 2020/4/5.
//  Copyright © 2020 sa. All rights reserved.
//

#import "RyzenAutoHeightCollectionView.h"

@implementation RyzenAutoHeightCollectionView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize]))
    {
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize
{
    CGSize intrinsicContentSize = self.contentSize;
    
    return intrinsicContentSize;
}


@end
