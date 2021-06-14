//
//  BaseHandle+SkeletonCollectLoading.m
//  StarScreenPlay
//
//  Created by 情热大陆 on 2018/3/13.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BaseHandle+SkeletonCollectLoading.h"
#import "OCSkeletonCollectDefaultCell.h"
@implementation BaseHandle (SkeletonCollectLoading)

- (OCSkeletonCollectDefaultCell *)generateCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = NSStringFromClass(OCSkeletonCollectDefaultCell.class);
    OCSkeletonCollectDefaultCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    for (CAGradientLayer *layer in cell.gradientLayers) {
        UIColor *baseColor = cell.titlePlaceholderView.backgroundColor;
        layer.colors = @[(id)baseColor.CGColor, (id)[[OCSkeletonCell generateBrightenedWithRaw:baseColor Factor:0.93] CGColor],(id) baseColor.CGColor];
    }
    // 设置圆角
    //    cell.layer.cornerRadius = 5.0;
    [cell slideToDir:OCDirectionRight animations:nil];
    return cell;
}
-(NSString *)defaultCellIdentifier
{
    return [NSString stringWithFormat:@"%@DefaultCell",NSStringFromClass(self.class)];
}
#pragma mark - <UICollectionViewDataSource>

- (NSInteger)customCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
- (UICollectionViewCell *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [self defaultCellIdentifier];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
-(void)customCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.tableIsLoading){
        return 25;
    }
    return [self customCollectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableIsLoading) {
        return [self generateCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    return [self customCollectionView:collectionView cellForItemAtIndexPath:indexPath];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableIsLoading) {
        return;
    }
    [self customCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

@end
