//
//  SMAIBInspectable.m
//  GoodEasyShop
//
//  Created by Curse Tom on 2020/7/11.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//

#import "SMAIBInspectable.h"
#import "ScreenMeasureAdapterConst.h"
#import <objc/runtime.h>

//定义常量 必须是C语言字符串
static char *AdapterScreenKey = "AdapterScreenKey";

@implementation NSLayoutConstraint (ScreenAdapter)


- (BOOL)adapterScreen{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
    return number.boolValue;
}

- (void)setAdapterScreen:(BOOL)adapterScreen {
    
    NSNumber *number = @(adapterScreen);
    objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapterScreen){
        self.constant = AdaptW(self.constant);
    }
}


@end


@implementation UILabel (ScreenAdapter)

- (BOOL)adapterScreen{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
    return number.boolValue;
}

- (void)setAdapterScreen:(BOOL)adapterScreen {
    
    NSNumber *number = @(adapterScreen);
    objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);    
    if (adapterScreen){
        self.font = [UIFont fontWithName:self.font.familyName size:AdaptW(self.font.pointSize)];
    }
}

@end


@implementation UIButton (ScreenAdapter)

- (BOOL)adapterScreen{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
    return number.boolValue;
}

- (void)setAdapterScreen:(BOOL)adapterScreen {
    
    NSNumber *number = @(adapterScreen);
    objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapterScreen){
        
        self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.familyName size:AdaptW(self.titleLabel.font.pointSize)];
    }
}

@end

//全圆角
static char *CornerRadiusAllKey = "CornerRadiusAllKey";

@implementation UIView (ScreenAdapter)

- (BOOL)cornerAll{
    NSNumber *number = objc_getAssociatedObject(self, CornerRadiusAllKey);
    return number.boolValue;
}

- (void)setCornerAll:(BOOL)cornerAll {
    
    NSNumber *number = @(cornerAll);
    objc_setAssociatedObject(self, CornerRadiusAllKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    /** 这里有个问题 xib可能高度获取不对 */
    if (cornerAll){
        self.layer.cornerRadius = self.height / 2;
    }
}


@end

@implementation UITextField (ScreenAdapter)

- (BOOL)adapterScreen{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
    return number.boolValue;
}

- (void)setAdapterScreen:(BOOL)adapterScreen {
    
    NSNumber *number = @(adapterScreen);
    objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapterScreen){
        self.font = [UIFont fontWithName:self.font.familyName size:AdaptW(self.font.pointSize)];
    }
}

@end
