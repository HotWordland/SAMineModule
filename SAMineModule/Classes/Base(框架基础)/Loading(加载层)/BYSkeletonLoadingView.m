//
//  BYSkeletonLoadingView.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/10.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BYSkeletonLoadingView.h"

@implementation BYSkeletonLoadingView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *tableView = [[UITableView alloc]init];
        [self configTableView:tableView];
        [self addSubview:tableView];
        self.tableView = tableView;
        self.loadingHandle = ({
            BYSkeletonLoadingHandle *handle =  [[BYSkeletonLoadingHandle alloc] initWithLoadingView:self];
            handle;
        });
    }
    return self;
}
-(void)configTableView:(UITableView *)tableView
{
    tableView.backgroundColor = self.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = false;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.size = self.size;
    self.tableView.top = 0;
    self.tableView.left = 0;
}
-(void)startLoading{
#warning 如果作为wyLoadingView 则按照viewDidLayout里面重写frame 或者 在startLoading的时候来进行frame调整
    if ([self superview]) {
        UIView *superView = [self superview];
        self.frame = superView.bounds;
    }
    self.loadingHandle.tableIsLoading = true;
    [self.tableView reloadData];
}
-(void)stopLoading{
    self.loadingHandle.tableIsLoading = false;
    [self.tableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
