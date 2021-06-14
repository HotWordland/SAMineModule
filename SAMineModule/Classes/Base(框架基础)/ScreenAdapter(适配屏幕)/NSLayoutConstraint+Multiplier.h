//
//  NSLayoutConstraint+Multiplier.h
//  CloudCulturalTourism
//
//  Created by Ryzen on 2020/10/22.
//  Copyright © 2020 cqlyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (Multiplier)
/** 更新ct的multiplier属性 */
-(instancetype)updateMultiplier:(CGFloat)multiplier;

@end

NS_ASSUME_NONNULL_END
