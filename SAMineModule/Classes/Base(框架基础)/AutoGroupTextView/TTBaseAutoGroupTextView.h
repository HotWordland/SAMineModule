//
//  TTBaseAutoGroupTextView.h
//  RiverBank
//
//  Created by Curse Tom on 2020/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 自动增长高度的TextView */
typedef void(^TextHeightChangedBlock)(CGFloat textHeight);
@interface TTBaseAutoGroupTextView : UITextView
/**
 *  textView最大行数
 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/**
 文字大小
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, strong) TextHeightChangedBlock textChangedBlock;
/**
 文字最大高度
 */
@property (nonatomic, assign) CGFloat maxTextH;

- (void)textValueDidChanged:(TextHeightChangedBlock)block;
/** 属性设置等 提供给子类重写 */
- (void)setup;

@end

NS_ASSUME_NONNULL_END
