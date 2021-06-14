//
//  TTBaseLoadingView.h
//  ThroughTrafficBus
//
//  Created by 巫龙 on 2018/1/25.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "TTBaseView.h"
#import <SpinKit/RTSpinKitView.h>
#import <WYNullView/WYNullView.h>

#warning 如果用于wy_loadingView则需要将类名加入白名单(WYNullView.bundle->classWhitelist.plist)

@interface TTBaseLoadingView : LoadingView
/**
 spinner指示器
 */
@property (strong, nonatomic) RTSpinKitView *spinner;
/**
 开始加载
 */
-(void)startLoading;

/**
 停止加载
 */
-(void)stopLoading;
@end
