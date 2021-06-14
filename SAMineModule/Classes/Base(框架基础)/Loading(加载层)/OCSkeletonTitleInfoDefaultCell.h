//
//  OCSkeletonTitleInfoDefaultCell.h
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/10.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "OCSkeletonCell.h"


/**
 OCSkeleton默认的标题头样式
 */
@interface OCSkeletonTitleInfoDefaultCell : OCSkeletonCell
/**
 增加的layer
 */
@property (weak, nonatomic) IBOutlet OCGradientContainerView *thridPlaceholderView;

/**
  顶部占位view firset
 */
@property (weak, nonatomic) IBOutlet OCGradientContainerView *topOnePlaceholderView;

/**
 顶部占位view second
 */
@property (weak, nonatomic) IBOutlet OCGradientContainerView *topSecondPlaceholderView;
/**
 banner头占位view
 */
@property (weak, nonatomic) IBOutlet OCGradientContainerView *bannerHolderView;
/**
 分割部分占位view
 */
@property (weak, nonatomic) IBOutlet OCGradientContainerView *sepHolderView;

+(CGFloat)getHeight;

@end
