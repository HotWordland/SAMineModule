//
//  BYSkeletonLoadingView.h
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/10.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import <WYNullView/WYNullView.h>
#import "BYSkeletonLoadingHandle.h"
/**
 骨架图loading
 */
@interface BYSkeletonLoadingView : LoadingView

/**
 表视图
 */
@property (strong, nonatomic) UITableView *tableView;

/**
 处理层
 */
@property (strong, nonatomic) BYSkeletonLoadingHandle *loadingHandle;
/** 配置tableView */
-(void)configTableView:(UITableView *)tableView;

@end
