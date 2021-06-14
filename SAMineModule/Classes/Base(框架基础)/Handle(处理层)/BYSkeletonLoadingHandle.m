//
//  BYSkeletonLoadingHandle.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/10.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BYSkeletonLoadingHandle.h"
#import "BYSkeletonLoadingView.h"
#import "OCSkeletonListInfoDefaultCell.h"
#import "OCSkeletonTitleInfoDefaultCell.h"
@interface BYSkeletonLoadingHandle()

/**
 加载view
 */
@property (strong, nonatomic) BYSkeletonLoadingView *loadingView;

/**
 OCSkeletonTitleInfoDefaultCell的高度 存到内存里面 不用每次滚动都去计算
 */
@property (assign, nonatomic) CGFloat titleCellHeight;

@end


@implementation BYSkeletonLoadingHandle
/**
 实例化
 
 @param loadingView loadingView实例
 @return handle
 */
-(instancetype)initWithLoadingView:(id)loadingView{
    self = [super init];
    if (self) {
        self.loadingView = (BYSkeletonLoadingView *)loadingView;
        self.loadingView.tableView.delegate = self;
        self.loadingView.tableView.dataSource = self;
        //如果工程为cocoapods 需要将xib文件添加到 s.resource 中
        //然后获取bundle的时候 需要调用[NSBundle bundleForClass:self.class]
        // 获取所在类的bundle 不然默认mainBundle 是获取不到xib 报错
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        [self.loadingView.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(OCSkeletonListInfoDefaultCell.class) bundle:bundle] forCellReuseIdentifier:NSStringFromClass(OCSkeletonListInfoDefaultCell.class)];
        [self.loadingView.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(OCSkeletonTitleInfoDefaultCell.class) bundle:bundle] forCellReuseIdentifier:NSStringFromClass(OCSkeletonTitleInfoDefaultCell.class)];
        self.titleCellHeight = [OCSkeletonTitleInfoDefaultCell getHeight];
    }
    return self;
}
/**
 生成OCSkeletonCell代理方法
 
 @param tableView 表视图
 @param indexPath index
 @return OCSkeletonCell
 */
- (OCSkeletonCell *)tableView:(UITableView *)tableView OCSkeletonCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([OCSkeletonListInfoDefaultCell class]);
    OCSkeletonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    for (CAGradientLayer *layer in cell.gradientLayers) {
        UIColor *baseColor = cell.titlePlaceholderView.backgroundColor;
        layer.colors = @[(id)baseColor.CGColor, (id)[[OCSkeletonListInfoDefaultCell generateBrightenedWithRaw:baseColor Factor:0.93] CGColor],(id) baseColor.CGColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/**
 生成OCSkeletonTitleCell代理方法
 
 @param tableView 表视图
 @param indexPath index
 @return OCSkeletonTitleInfoDefaultCell
 */
- (OCSkeletonCell *)tableView:(UITableView *)tableView OCSkeletonTitleCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([OCSkeletonTitleInfoDefaultCell class]);
    OCSkeletonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    for (CAGradientLayer *layer in cell.gradientLayers) {
        UIColor *baseColor = cell.titlePlaceholderView.backgroundColor;
        layer.colors = @[(id)baseColor.CGColor, (id)[[OCSkeletonListInfoDefaultCell generateBrightenedWithRaw:baseColor Factor:0.93] CGColor],(id) baseColor.CGColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.titleCellHeight;
    }
    return [OCSkeletonListInfoDefaultCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self tableView:tableView OCSkeletonTitleCellForRowAtIndexPath:indexPath];
    }
        return [self tableView:tableView OCSkeletonCellForRowAtIndexPath:indexPath];
}

@end
