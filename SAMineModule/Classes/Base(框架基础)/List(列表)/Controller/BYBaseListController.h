//
//  BYBaseListController.h
//  BYLottery
//
//  Created by 巫龙 on 2018/1/10.
//  Copyright © 2018年 Lon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListHandle.h"
@interface BYBaseListController : TTBaseController

/**
 表
 */
@property (nonatomic,strong) UITableView *tableView;
/**
 处理层
 */
@property (nonatomic,strong) BaseListHandle *handle;
/**
 子类集成实现更过的细节内容
 */
-(void)configTableView;
@end
