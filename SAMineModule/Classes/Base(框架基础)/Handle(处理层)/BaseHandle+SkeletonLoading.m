//
//  BaseHandle+SkeletonLoading.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/3/6.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BaseHandle+SkeletonLoading.h"

@implementation BaseHandle (SkeletonLoading)
/**
 生成OCSkeletonCell代理方法
 
 @param tableView 表视图
 @param indexPath index
 @return OCSkeletonCell
 */
- (OCSkeletonCell *)tableView:(UITableView *)tableView OCSkeletonCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([OCSkeletonCell class]);
    OCSkeletonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    for (CAGradientLayer *layer in cell.gradientLayers) {
        UIColor *baseColor = cell.titlePlaceholderView.backgroundColor;
        layer.colors = @[(id)baseColor.CGColor, (id)[[OCSkeletonCell generateBrightenedWithRaw:baseColor Factor:0.93] CGColor],(id) baseColor.CGColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 注册SkeletonLoadingCell

 @param tableView 表视图
 */
-(void)registerSkeletonLoadingCell:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(OCSkeletonCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(OCSkeletonCell.class)];
}

-(UIView *)customTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.tableIsLoading) {
        return nil;
    }
    return [self customTableView:tableView viewForHeaderInSection:section];
}
-(CGFloat)customTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.tableIsLoading) {
        return 0;
    }
    return [self customTableView:tableView heightForHeaderInSection:section];
}
#pragma mark - Custom UITableView Datasource/Delegate
- (NSInteger)customTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)customTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    
    return cell;
}
- (void)customTableView:(UITableView *)tableView willDisplayCell:(OCSkeletonCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableIsLoading) {
        [cell slideToDir:OCDirectionRight animations:nil];
    }
}
- (CGFloat)customTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}
- (void)customTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (NSInteger)customNumberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.tableIsLoading){
        return 1;
    }
    return [self customNumberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.tableIsLoading){
        return 25;
    }
    return [self customTableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableIsLoading) {
        return [self tableView:tableView OCSkeletonCellForRowAtIndexPath:indexPath];
    }
    return [self customTableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark- UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(OCSkeletonCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableIsLoading) {
        [cell slideToDir:OCDirectionRight animations:nil];
    }
    [self customTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableIsLoading) {
        return 70.0f;
    }
    return [self customTableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableIsLoading) {
        return;
    }
    [self customTableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
