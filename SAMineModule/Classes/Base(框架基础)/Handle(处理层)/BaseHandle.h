//
//  BaseHandle.h
//  ThroughTrafficBus
//
//  Created by 情热大陆 on 2018/1/26.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSkeletonCell.h"
#import <YYKit/YYKit.h>
@interface BaseHandle : NSObject
/**
 列表是否正在加载(主要面对没有继承BaseListHandle的情况,自定义性强的一些列表)
 */
@property (assign, nonatomic) BOOL tableIsLoading;

/**
 路线列表请求回调
 */
@property (copy, nonatomic) void(^roadLineCall)(NSMutableArray *list);

/**
 占位图placeholder

 @param size 裁剪的大小
 @return img
 */
+(UIImage *)placeHolder:(CGSize)size;
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
 头像圆角
 
 @return YYWebImageManager
 */
+ (YYWebImageManager *)avatarImageManager;

/**
 配置loadingView

 @param v 加载view
 @param bounds 尺寸
 */
+(void)configLoadingView:(UIView *)v bounds:(CGRect)bounds;

/**
 剧本评分的辅助函数转Float

 @param price 参数
 @return float
 */
+(float)scriptRatingRoundFloat:(float)price;

/**
 友好字符

 @param originString 原始字符串
 @return NSString
 */
+(NSString *)friendString:(NSString *)originString;
/**
 友好字符 - 替换
 
 @param originString 原始字符串
 @return NSString
 */
+(NSString *)friendString:(NSString *)originString replaceString:(NSString *)replaceString;
/**
 正则匹配手机号
 
 @param telNumber 电话号码
 @return flag
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber;
/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str;

/** 获取版本号 */
+(NSString *)getAppVersion;
/**
 生成用户accesskey拼接到来源的urlString上 如果有
 @params purlString 来源urlString
 */
+(NSString *)genUserLoginStateAccesskeyQueryString:(NSString *)purlString;
/** 转为北京时间 */
+ (NSDate *)dateChangeToGMTNormal:(NSDate *)fromDate;

@end
