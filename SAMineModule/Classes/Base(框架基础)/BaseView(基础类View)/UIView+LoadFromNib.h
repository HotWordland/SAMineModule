//
//  UIView+LoadFromNib.h
//  Travel-Tp
//
//  Created by Ryzen on 2019/10/30.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LoadFromNib)
+ (instancetype)fm_viewFromXib;

+ (NSString *)fm_xibFileName;
/**
 加载xib文件 针对xib继承的情况
 */
-(void)fm_instanceLoadXib;

@end

NS_ASSUME_NONNULL_END
