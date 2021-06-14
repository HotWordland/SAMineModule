//
//  BaseCollectListHandle.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BaseCollectListHandle.h"
#import "MJRefresh.h"
#import "TTRefreshHeader.h"
#import "TTRefreshFooter.h"
#import "OCSkeletonCollectDefaultCell.h"
#import "BaseHandle+SkeletonCollectLoading.h"
@interface BaseCollectListHandle()
/**
 当前页码
 */
@property (nonatomic, assign) NSUInteger page;
/**
 refresh刷新header
 */
@property (nonatomic, strong) TTRefreshHeader *header;

/**
 refresh刷新footer
 */
@property (nonatomic, strong) TTRefreshFooter *footer;

@end

@implementation BaseCollectListHandle
-(instancetype)initWithCollectView:(UICollectionView *)collectView{
    self = [super init];
    if (self) {
        _collectView = collectView;
        _collectView.delegate = self;
        _collectView.dataSource = self;
//        TTBaseLoadingView *loadingView = [[TTBaseLoadingView alloc]initWithFrame:_tableView.bounds];
//        loadingView.backgroundColor = _tableView.backgroundColor;
//        _tableView.wy_loadingView = loadingView;
        NSString *cellID = [self defaultCellIdentifier];
        [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectView registerNib:[UINib nibWithNibName:NSStringFromClass([OCSkeletonCollectDefaultCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass(OCSkeletonCollectDefaultCell.class)];
        [self collectViewRegisterCells];
        _collectView.backgroundColor = [UIColor colorWithHexString:@"F0F5F6"];
        _page = 1;
        self.tableIsLoading = true;
        [self.collectView reloadData];
        [self loadDataWithShowProgress:true];
        
    }
    return self;
}

/**
 重写这个方法来实现自定义的cell注册
 */
-(void)collectViewRegisterCells
{
    
}
/**
 生成布局

 @return UICollectionViewFlowLayout
 */
+(UICollectionViewFlowLayout *)generateCollectFlowLayout
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = YYScreenSize().width/2;
//    CGFloat itemHeight = itemWidth;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(itemWidth, [self.class itemHeight]);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}

/**
 默认返回每个item的高度

 @return CGFloat
 */
+(CGFloat)itemHeight{
    return 220;
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
            if ([self.collectView wy_nullView]) {
                [self.collectView wy_hideNullView];
            }
            //请求的时候如果总数为10也就是请求每一页的数量足够的话 就显示refresh footer
            self.collectView.mj_footer = [self footer];
            [self.footer resetNoMoreData];
            
        }else{
            //如果请求到的数据为0则显示空视图
            if (models.count == 0) {
                [self showTableViewNullView];
                [self.collectView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
            }else{
                if ([self.collectView wy_nullView]) {
                    [self.collectView wy_hideNullView];
                }
                //清除空白线
//                self.collectView.tableFooterView = [UIView new];
                self.collectView.mj_footer = [self footer];
                [self.footer endRefreshingWithNoMoreData];
            }
            
        }
        
        [self.collectView reloadData];
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
        [self.collectView reloadData];
    } failed:^(NSError *error) {
        [self showTableViewNullView];
        [self.collectView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
        
    }];
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
//    if (isShowProgress) {
//        [self initLoadingViewWithFullLoading] ? dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.collectView wy_startLoding];
//        }) : [ProgressHUD show:@"正在加载" Interaction:NO];
//
//    }
    NSUInteger pagesize = [self singlePageRequestCount];
    NSTimeInterval delayTime = [self initLoadingViewWithFullLoading] ? 0.2 : 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //执行逻辑
        [self get_playcount_record_with_params:params Success:^(id data) {
            [ProgressHUD dismiss];
            self.tableIsLoading = false;
            NSArray *models = data;
            self.list = [[NSMutableArray alloc] initWithArray:models];
            // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.collectView reloadData];
            if ([self initLoadingViewWithFullLoading]) {
                [self.collectView wy_stopLoding];
            }
            if([self.list count]>0){
                if (self.collectView.wy_nullView) {
                    [self.collectView wy_hideNullView];
                }
                self.collectView.mj_header = [self header];
                if ([self.list count] == pagesize) {
                    self.collectView.mj_footer = [self footer];
                    [self.footer resetNoMoreData];
                    
                }else{
                    self.collectView.mj_footer = [self footer];
                    [self.footer endRefreshingWithNoMoreData];
                    
                }
            }else{
                [self showTableViewNullView];
                [self.collectView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
                self.collectView.mj_header = [self header];
                
            }
            
        } failed:^(NSError *error) {
            [ProgressHUD dismiss];
            if ([self initLoadingViewWithFullLoading]) {
                [self.collectView wy_stopLoding];
            }
            [self showTableViewNullView];
            [self.collectView wy_nullViewAddTarget:self action:@selector(nullViewClickAction:)];
        }];
    });
}
/**
 没有数据情况时候调用
 */
-(void)showTableViewNullView
{
    [self.collectView wy_showNullView];
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

-(NSUInteger)singlePageRequestCount{
    return 10;
}

/**
 是否Full屏幕显示loading
 
 @return flag
 */
-(BOOL)initLoadingViewWithFullLoading
{
    return true;
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
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)customCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}

@end
