//
//  TTBaseWaterFallLayout.h
//  CloudCulturalTourism
//
//  Created by Ryzen on 2020/10/22.
//  Copyright © 2020 cqlyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TTBaseWaterFallLayout;
// Extend from the NSObject protocol so it is safe to call `respondsToSelector`
@protocol TTBaseWaterFallLayoutDelegate <NSObject>
// headersize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(TTBaseWaterFallLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;

// footer 的 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(TTBaseWaterFallLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@required
//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(TTBaseWaterFallLayout *_Nullable)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *_Nullable)indexPath;
@optional
/**
 计算contentsize完成
*/
- (void)contentSizeCalDone:(CGSize)size;
@end

/**
 瀑布流布局
*/
@interface TTBaseWaterFallLayout : UICollectionViewLayout
//总列数
@property (nonatomic, assign) NSInteger columnCount;
//列间距
@property (nonatomic, assign) NSInteger columnSpacing;
//行间距
@property (nonatomic, assign) NSInteger rowSpacing;
//section到collectionView的边距
@property (nonatomic, assign) UIEdgeInsets sectionInset;
//保存每一列最大y值的数组
@property (nonatomic, strong) NSMutableDictionary *maxYDic;
//保存每一个item的attributes的数组
@property (nonatomic, strong) NSMutableArray *attributesArray;
//代理，用来计算item的高度
@property (nonatomic, weak) id<TTBaseWaterFallLayoutDelegate> delegate;

@property (nonatomic,assign) CGSize headerReferenceSize;

@property (nonatomic,assign) CGSize footerReferenceSize;

@end

NS_ASSUME_NONNULL_END
