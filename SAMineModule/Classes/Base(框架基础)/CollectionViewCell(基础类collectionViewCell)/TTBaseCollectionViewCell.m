//
//  TTBaseCollectionViewCell.m
//  GoodEasyShop
//
//  Created by Curse Tom on 2020/5/10.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//

#import "TTBaseCollectionViewCell.h"

@implementation TTBaseCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self highlightHandle:highlighted];
}

/**
 高亮的处理
 交给子类复写
*/
-(void)highlightHandle:(BOOL)highlighted
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = highlighted ? 0.6 : 1;
    }];
}
/**
 计算对应的xib视图高度
*/
+(CGFloat)calHeightWithXibWidth:(CGFloat)width Class:(Class)className{
    UICollectionViewCell *cell =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(className) owner:nil options:nil] firstObject];
    PREPCONSTRAINTS(cell.contentView);
    CONSTRAIN_WIDTH(cell.contentView, width);
    [cell.contentView layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}
/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */
-(void)eventEmit:(id)event param:(id)param
{
    !self.emitEvent ?: self.emitEvent(event, param);
}

@end
