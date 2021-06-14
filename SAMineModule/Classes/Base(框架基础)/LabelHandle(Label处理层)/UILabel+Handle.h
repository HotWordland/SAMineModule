//
//  UILabel+Handle.h
//  Travel-Tp
//
//  Created by Curse Tom on 2019/12/12.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Handle)
/**
 设置文字行间距
 @param text 内容
 @param lineSpacing 间距
*/
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
@end

NS_ASSUME_NONNULL_END
