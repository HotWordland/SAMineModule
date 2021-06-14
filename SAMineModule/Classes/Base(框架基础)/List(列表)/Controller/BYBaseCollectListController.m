//
//  BYBaseCollectListController.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BYBaseCollectListController.h"

@interface BYBaseCollectListController ()

@end

@implementation BYBaseCollectListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self collectView];
}
-(UICollectionView *)collectView{
    if (!_collectView) {
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100) collectionViewLayout:[self collectFlowLayout]];
        [self configTableView];
        //绑定处理层
        _handle = [self generateHandle];
        if (![_collectView superview]) {
            PREPCONSTRAINTS(_collectView);
            [self.view addSubview:_collectView];
            ALIGN_LEFT(_collectView, 0);
            ALIGN_RIGHT(_collectView, 0);
            ALIGN_TOP(_collectView, 0);
            ALIGN_BOTTOM(_collectView, 0);
        }
    }
    return _collectView;
}
-(UICollectionViewFlowLayout *)collectFlowLayout
{
    return [BaseCollectListHandle generateCollectFlowLayout];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 子类集成实现更过的细节内容
 */
-(void)configTableView
{
    _collectView.backgroundColor = self.view.backgroundColor;
//    _collectView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 交给子类重写来实现自定义handle
 
 @return handle类
 */
-(BaseCollectListHandle *)generateHandle{
    return [[BaseCollectListHandle alloc] initWithCollectView:self.collectView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
