//
//  SSGifLoadingView.h
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/12/26.
//  Copyright © 2018 巫龙. All rights reserved.
//

#import <WYNullView/WYNullView.h>
#import <YYKit/YYKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSGifLoadingView : LoadingView
// gif container
@property (strong, nonatomic) YYAnimatedImageView *gifLoadingView;
@end

NS_ASSUME_NONNULL_END
