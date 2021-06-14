//
//  BaseCollectListHandle.h
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BaseHandle.h"
#import "BaseCollectListHandle.h"
/**
 基础列表controller - 带collectionView的处理层
 */
@interface BaseCollectListHandle : BaseHandle<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 表视图
 */
@property (nonatomic,weak) UICollectionView *collectView;
/**
 数据源
 */
@property (nonatomic,strong) NSMutableArray *list;

/**
 控制器
 */
@property (weak, nonatomic) UIViewController *controller;

/**
 实例化

 @param collectView collect视图
 @return 实例
 */
-(instancetype)initWithCollectView:(UICollectionView *)collectView;
/**
 生成布局
 
 @return UICollectionViewFlowLayout
 */
+(UICollectionViewFlowLayout *)generateCollectFlowLayout;
/**
 默认返回每个item的高度
 
 @return CGFloat
 */
+(CGFloat)itemHeight;
@end
