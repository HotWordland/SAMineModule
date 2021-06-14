//
//  UIView+SSShowNull.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/5/29.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "UIView+SSShowNull.h"

@implementation UIView (SSShowNull)

-(void)ssShowEmpty
{
    [self wy_showNullView:^UIView *(NullView *defaultNullView) {
        defaultNullView.actLbl.text = @"";
        return defaultNullView;
    }];
}

@end
