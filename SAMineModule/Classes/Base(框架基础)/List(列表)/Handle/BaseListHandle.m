//
//  BaseListHandle.m
//  BYLottery
//
//  Created by 巫龙 on 2018/1/10.
//  Copyright © 2018年 Lon. All rights reserved.
//

#import "BaseListHandle.h"
#import "SSGifLoadingView.h"

@implementation BaseListHandle

-(instancetype)initWithTableView:(UITableView *)tableView controller:(id)controller{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        BYSkeletonLoadingView *loadingView = [[BYSkeletonLoadingView alloc]initWithFrame:_tableView.bounds];
//        loadingView.backgroundColor = _tableView.backgroundColor;
        _tableView.wy_loadingView = loadingView;
        _page = 1;
        _controller = controller;    
        [self loadDataWithShowProgress:true];
    }
    return self;
}

-(instancetype)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        BYSkeletonLoadingView *loadingView = [[BYSkeletonLoadingView alloc]initWithFrame:_tableView.bounds];
//        loadingView.backgroundColor = _tableView.backgroundColor;
        _tableView.wy_loadingView = loadingView;
        _page = 1;
        [self loadDataWithShowProgress:true];
    }
    return self;
}
-(void)addTableHeader
{
    
}

/**
 没有数据情况时候调用
 */
-(void)showTableViewNullView
{
    [self.tableView wy_showNullView];
}
-(void)setPage:(NSUInteger)page{
    _page = page;
}

/**
 是否Full屏幕显示loading

 @return flag
 */
-(BOOL)initLoadingViewWithFullLoading
{
    
    return true;
}

/**
 手动header刷新
 */
-(void)headerRefreshData
{
    [self.header beginRefreshing];
}
/**
 初次加载数据
 */
-(void)loadDataWithShowProgress:(BOOL)isShowProgress{
    NSDictionary *params = @{
                             @"pageNum":@"1"                             
                             };
    params = [self generate_common_params:params];
    if (isShowProgress) {
        [self initLoadingViewWithFullLoading] ? [self.tableView wy_startLoding] : [ProgressHUD show:@"正在加载" Interaction:NO];
        
    }
    NSUInteger pagesize = [self singlePageRequestCount];
    NSTimeInterval delayTime = [self initLoadingViewWithFullLoading] ? 0.2 : 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //执行逻辑
        [self get_playcount_record_with_params:params Success:^(id data) {
            [ProgressHUD dismiss];
            NSArray *models = data;
            self.list = [[NSMutableArray alloc] initWithArray:models];
            // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView reloadData];
            if ([self initLoadingViewWithFullLoading]) {
                [self.tableView wy_stopLoding];
            }
            if([self.list count]>0){
                if (self.tableView.wy_nullView) {
                    [self.tableView wy_hideNullView];
                }
                self.tableView.mj_header = [self header];
                if ([self.list count] == pagesize) {
                    self.tableView.mj_footer = [self footer];
                    [self.footer resetNoMoreData];
                }else{
                    self.tableView.mj_footer = [self footer];
                    [self.footer endRefreshingWithNoMoreData];
                }
            }else{
                [self showTableViewNullView];
                [self.tableView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
                self.tableView.mj_header = [self header];
                
            }
            
        } failed:^(NSError *error) {
            [ProgressHUD dismiss];
            if ([self initLoadingViewWithFullLoading]) {
                [self.tableView wy_stopLoding];
            }
            [self showTableViewNullView];
            [self.tableView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
        }];
    });
}

/**
 如果list为空了则刷新TableView的状态
 其实这里如果用kvo来实现list count值的监听也是可以的
 但是 要实现这种list的地址会改变 因为自己的业务逻辑很多是于list的值共享的,故放弃
 */
-(void)updateListIfNull
{
    if (self.list.count==0) {
        [self showTableViewNullView];
        [self.tableView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
    }
}
/**
 空视图点击事件

 @param tap 手势对象
 */
-(void)nullViewClickAction:(UITapGestureRecognizer *)tap{
    [ProgressHUD show:@"正在重新请求"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadDataWithShowProgress:false];
    });
}
#pragma mark - Refresh config
- (TTRefreshFooter *)footer
{
    if (!_footer) {
        _footer = [TTRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpToRefresh)];
    }
    return _footer;
}

- (TTRefreshHeader *)header
{
    if (!_header) {
        _header = [TTRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownToRefresh)];
    }
    return _header;
}
-(NSUInteger)singlePageRequestCount{
    return 10;
}
#pragma mark - Refresh 模拟测试请求
-(void)get_playcount_record_with_params:(NSDictionary *)dic Success:(void(^)(id data))success failed:(void(^)(NSError *error))fail{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (NSUInteger i = 0;  i < 4 ;i++ ) {
            [temp addObject:@"wonderland"];
        }
        success(temp);
    });
}
-(NSDictionary *)generate_common_params:(NSDictionary *)params{
    NSMutableDictionary *result = [[NSMutableDictionary alloc]initWithDictionary:params];
    NSUInteger pagesize = [self singlePageRequestCount];
    NSNumber *pagesizeNumber = [NSNumber numberWithInteger:pagesize];
    [result addEntriesFromDictionary:@{
                                       @"pageSize":pagesizeNumber
                                       }];
    return result;
    
    
}

#pragma mark - Refresh action

- (void)pullDownToRefresh
{
    NSDictionary *params = @{
                             @"pageNum":@"1"
                             };
    params = [self generate_common_params:params];
    NSUInteger pagesize = [self singlePageRequestCount];    
    [self get_playcount_record_with_params:params Success:^(id data) {
        NSArray *models = data;
        self.page = 1;
        self.list = [[NSMutableArray alloc] initWithArray:models];
        //        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (models.count == pagesize){
            if ([self.tableView wy_nullView]) {
                [self.tableView wy_hideNullView];
            }
            //请求的时候如果总数为10也就是请求每一页的数量足够的话 就显示refresh footer
            self.tableView.mj_footer = [self footer];
            [self.footer resetNoMoreData];
            
        }else{
            //如果请求到的数据为0则显示空视图
            if (models.count == 0) {
                [self showTableViewNullView];
                [self.tableView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
            }else{
                if ([self.tableView wy_nullView]) {
                    [self.tableView wy_hideNullView];
                }
                //清除空白线
                self.tableView.tableFooterView = [UIView new];
                self.tableView.mj_footer = [self footer];
                [self.footer endRefreshingWithNoMoreData];
            }
        }
        [self.tableView reloadData];
        [self.header endRefreshing];
    } failed:^(NSError *error) {
    }];
}

- (void)pullUpToRefresh
{
    ++self.page;
    NSDictionary *params = @{
                             @"pageNum" : @(self.page)
                             };
    params = [self generate_common_params:params];
    NSUInteger pagesize = [self singlePageRequestCount];
    
    [self get_playcount_record_with_params:params Success:^(id data) {
        NSArray *models = data;
        if (models.count < pagesize) {
            //            self.page--;
            [self.footer endRefreshingWithNoMoreData];
//            [self.tableView.footRefreshControl endRefreshing];
        } else{
            [self.footer resetNoMoreData];
//            [self.tableView.footRefreshControl endRefreshing];
        }
        [self.list addObjectsFromArray:models];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [self showTableViewNullView];
        [self.tableView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
        
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld",indexPath.row];
    [cell setTag:indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
