//
//  BaseListHandle.h
//  BYLottery
//
//  Created by 巫龙 on 2018/1/10.
//  Copyright © 2018年 Lon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHandle.h"
#import "TTRefreshHeader.h"
#import "TTRefreshFooter.h"
#import "TTBaseLoadingView.h"
#import "BYSkeletonLoadingView.h"

@interface BaseListHandle : BaseHandle<UITableViewDelegate,UITableViewDataSource>

/**
 表视图
 */
@property (nonatomic,weak) UITableView *tableView;

/**
 refresh刷新header
 */
@property (nonatomic, strong) TTRefreshHeader *header;

/**
 refresh刷新footer
 */
@property (nonatomic, strong) TTRefreshFooter *footer;

/**
 Full加载视图
 */
//@property (strong, nonatomic) TTBaseLoadingView *loadingView;

/**
 当前页码
 */
@property (nonatomic, assign) NSUInteger page;

/**
 数据源
 */
@property (nonatomic,strong) NSMutableArray *list;

/**
 初始化

 @param tableView 表视图
 @return 实例
 */
-(instancetype)initWithTableView:(UITableView *)tableView;

/**
 控制器
 */
@property (weak, nonatomic) id controller;

/**
 手动开始下拉刷新获取数据
 */
-(void)headerRefreshData;
/**
 初次加载数据
 */
-(void)loadDataWithShowProgress:(BOOL)isShowProgress;

/**
 page set方法暴露接口
 
 @param page 当前页码
 */
-(void)setPage:(NSUInteger)page;
/**
 如果list为空了则刷新TableView的状态
 其实这里如果用kvo来实现list count值的监听也是可以的
 但是 要实现这种list的地址会改变 因为自己的业务逻辑很多是于list的值共享的,故放弃
 */
-(void)updateListIfNull;
/**
 初始化内容
 
 @param tableView 表视图
 @param controller 控制器
 @return 实例
 */
-(instancetype)initWithTableView:(UITableView *)tableView controller:(id)controller;

/**
 没有数据情况时候调用
 */
-(void)showTableViewNullView;
/**
 是否Full屏幕显示loading

 @return flag
 */
-(BOOL)initLoadingViewWithFullLoading;

@end
