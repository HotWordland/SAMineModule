//
//  OCSkeletonCollectDefaultCell.h
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCSkeleton.h"

@interface OCSkeletonCollectDefaultCell : UICollectionViewCell<OCGradientsOwner>
@property (weak, nonatomic) IBOutlet OCGradientContainerView *titlePlaceholderView;
@property (weak, nonatomic) IBOutlet OCGradientContainerView *subtitlePlaceholderView;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlaceholderView;

/**
 背景图view
 */
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
