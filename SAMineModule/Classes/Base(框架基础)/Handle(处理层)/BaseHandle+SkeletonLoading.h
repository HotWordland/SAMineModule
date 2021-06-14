//
//  BaseHandle+SkeletonLoading.h
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/3/6.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BaseHandle.h"


/**
 列表占位处理 SkeletonScreen
 */
@interface BaseHandle (SkeletonLoading)<UITableViewDelegate,UITableViewDataSource>
/**
 生成OCSkeletonCell代理方法
 
 @param tableView 表视图
 @param indexPath index
 @return OCSkeletonCell
 */
- (OCSkeletonCell *)tableView:(UITableView *)tableView OCSkeletonCellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 注册SkeletonLoadingCell
 
 @param tableView 表视图
 */
-(void)registerSkeletonLoadingCell:(UITableView *)tableView;
@end
