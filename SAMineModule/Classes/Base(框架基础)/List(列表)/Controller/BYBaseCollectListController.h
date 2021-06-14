//
//  BYBaseCollectListController.h
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "TTBaseController.h"
#import "BaseCollectListHandle.h"
/**
 基础列表controller - 带collectionView
 */
@interface BYBaseCollectListController : TTBaseController
/**
 列表视图
 */
@property (strong, nonatomic) UICollectionView *collectView;
/**
 处理层
 */
@property (nonatomic,strong) BaseCollectListHandle *handle;
/**
 子类集成实现更过的细节内容
 */
-(void)configTableView;

@end
