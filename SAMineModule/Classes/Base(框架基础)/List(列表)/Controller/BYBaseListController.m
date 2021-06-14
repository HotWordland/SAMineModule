//
//  BYBaseListController.m
//  BYLottery
//
//  Created by 巫龙 on 2018/1/10.
//  Copyright © 2018年 Lon. All rights reserved.
//

#import "BYBaseListController.h"
#import "BYSkeletonLoadingView.h"
#import "SSGifLoadingView.h"
@interface BYBaseListController()

@end

@implementation BYBaseListController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [self configTableView];
        //绑定处理层
        _handle = [self generateHandle];
        if (![_tableView superview]) {
            PREPCONSTRAINTS(_tableView);
            [self.view addSubview:_tableView];
            ALIGN_LEFT(_tableView, 0);
            ALIGN_RIGHT(_tableView, 0);
            ALIGN_TOP(_tableView, 0);
            ALIGN_BOTTOM(_tableView, 0);
        }
    }
    return _tableView;
}
/**
 子类集成实现更过的细节内容
 */
-(void)configTableView
{
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /*
     iOS 11中，tableView默认启用Self-Sizing
     所以，tableView的contentSize大小一开始也是不准确的，会随着滑动逐渐变化
     会造成reloadData后contentOffSet不准确
     需要关闭这个功能
     注意三个属性都需要设置，即使你没用到sectionHeader或者sectionFooter也要设置！！！
     */
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;

}

/**
 交给子类重写来实现自定义handle

 @return handle类
 */
-(BaseListHandle *)generateHandle{
    return [[BaseListHandle alloc] initWithTableView:_tableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    BOOL foundLoading = false;
    BOOL foundTableLoading = false;
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[BYSkeletonLoadingView class]]) {
            [v setSize:self.view.size];
            [v setLeft:0];
            [v setTop:0];
            foundLoading = true;
            if (foundLoading&&foundTableLoading) {
               break;
            }
        }
        if ([v isKindOfClass:[UITableView class]]) {
            for (UIView *subv in v.subviews) {
                //在baselisthandle 中loading属于tableview的子view
                //但是始终得不到frame的值一直为CGZero 可能是tableview还没显示上去
                //所以得不到frame的值
                //所以在这里进行赋值
                if ([subv isKindOfClass:[BYSkeletonLoadingView class]]) {
                    [subv setSize:v.size];
                    [subv setLeft:0];
                    [subv setTop:0];
                    break;
                }
            }
            foundTableLoading = true;
            if (foundLoading&&foundTableLoading) {
                break;
            }
        }
    }

}
@end
