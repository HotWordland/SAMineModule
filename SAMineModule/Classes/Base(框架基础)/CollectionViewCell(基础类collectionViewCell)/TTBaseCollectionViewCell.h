//
//  TTBaseCollectionViewCell.h
//  GoodEasyShop
//
//  Created by Curse Tom on 2020/5/10.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
基础UICollectionViewCell
*/
@interface TTBaseCollectionViewCell : UICollectionViewCell
/**
 集合视图
 */
@property (weak, nonatomic) UICollectionView *collectView;
/**
 handle层
 */
@property (weak, nonatomic) id handle;
/**
 数据源
*/
@property (weak, nonatomic) id info;
/**
 事件block
 */
@property (copy, nonatomic) void(^emitEvent)(id event,id param);
/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */

-(void)eventEmit:(id)event param:(id)param;
/**
 计算对应的xib视图高度
 */
+(CGFloat)calHeightWithXibWidth:(CGFloat)width Class:(Class)className;


@end

NS_ASSUME_NONNULL_END
