//
//  ScreenMeasureAdapterConst.h
//  GoodEasyShop
//
//  Created by Curse Tom on 2020/7/11.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//
/**
 ScreenMeasureAdapter常量/方法
 */
// 基准屏幕宽度
#define kRefereWidth 375.0
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) ^CGFloat (){\
   CGFloat measure = MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);\
   return  (floatValue*measure/kRefereWidth);\
}()
