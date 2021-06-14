//
//  TTFeedAlert.h
//  Travel-Tp
//
//  Created by Curse Tom on 2020/3/19.
//  Copyright © 2020 Ryzen. All rights reserved.
//

#import "TTBaseView.h"

NS_ASSUME_NONNULL_BEGIN
/**
 基础的反馈弹框视图
*/
@interface TTFeedAlert : TTBaseView
/**
 标题
*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 描述
*/
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

NS_ASSUME_NONNULL_END
