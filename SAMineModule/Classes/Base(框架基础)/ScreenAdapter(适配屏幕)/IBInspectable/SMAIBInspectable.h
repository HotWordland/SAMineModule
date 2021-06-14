//
//  SMAIBInspectable.h
//  GoodEasyShop
//
//  Created by Curse Tom on 2020/7/11.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 屏幕适配提供的一些xib中的IBInspectable接口和方法
 */
@interface NSLayoutConstraint (ScreenAdapter)
//true代表需要对屏幕进行等比例适配
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

@interface UILabel (ScreenAdapter)
//true代表需要对屏幕进行等比例适配
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

@interface UIButton (ScreenAdapter)
//true代表需要对屏幕进行等比例适配
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

@interface UIView (ScreenAdapter)
//true代表全圆角
@property(nonatomic, assign) IBInspectable BOOL cornerAll;

@end

@interface UITextField (ScreenAdapter)
//true代表需要对屏幕进行等比例适配
@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end


NS_ASSUME_NONNULL_END
