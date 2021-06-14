//
//  UILabel+Handle.m
//  Travel-Tp
//
//  Created by Curse Tom on 2019/12/12.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "UILabel+Handle.h"

@implementation UILabel (Handle)
/**
 设置文字行间距
 @param text 内容
 @param lineSpacing 间距
*/
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

@end
