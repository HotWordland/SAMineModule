//
//  BYBaseShowModalHandle.h
//  StarScreenPlay
//
//  Created by 巫龙 on 2019/4/10.
//  Copyright © 2019 巫龙. All rights reserved.
//

#import "BaseHandle.h"
#import "TTBaseView.h"
NS_ASSUME_NONNULL_BEGIN
// view show modal state handle
@interface BYBaseShowModalHandle : BaseHandle
// post tool view
@property (weak, nonatomic) TTBaseView *postToolView;
// controller weak reference
@property (weak, nonatomic) UIViewController *controller;
// bgview and touch to dismiss
@property (strong, nonatomic) UIView *bgView;
// show animation
-(void)show;
// dismiss animation
-(void)dismiss;
// init function
-(instancetype)initWithToolView:(TTBaseView *)toolView Controller:(UIViewController *)controller;
// load
-(void)loadPostToolView;

@end

NS_ASSUME_NONNULL_END
