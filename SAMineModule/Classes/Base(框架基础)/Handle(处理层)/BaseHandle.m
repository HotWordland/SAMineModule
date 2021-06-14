//
//  BaseHandle.m
//  ThroughTrafficBus
//
//  Created by 情热大陆 on 2018/1/26.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BaseHandle.h"
#import <WYNullView/WYNullView.h>
#import "TTBaseLoadingView.h"
@implementation BaseHandle

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(NSString *)friendString:(NSString *)originString
{
    NSString *friendString = @"暂无";
    NSString *resultString = originString ? originString : friendString;
    if ([originString isKindOfClass:[NSNull class]]) {
        resultString = friendString;
    }
    return resultString;
}
+(NSString *)friendString:(NSString *)originString replaceString:(NSString *)replaceString
{
    NSString *friendString = replaceString;
    NSString *resultString = originString ? originString : friendString;
    if ([originString isKindOfClass:[NSNull class]]) {
        resultString = friendString;
    }
    return resultString;
}

+(void)configLoadingView:(UIView *)v bounds:(CGRect)bounds{
    if (![v.wy_loadingView isKindOfClass:[TTBaseLoadingView class]]) {        
        TTBaseLoadingView *loadingView = [[TTBaseLoadingView alloc]initWithFrame:bounds];
        v.wy_loadingView = loadingView;
    }
    [v bringSubviewToFront:v.wy_loadingView];
}
+(float)scriptRatingRoundFloat:(float)price{
    NSString *temp = [NSString stringWithFormat:@"%.7f",price];
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
}
/*!
 @brief 修正浮点型精度丢失
 @param str 传入接口取到的数据
 @return 修正精度后的数据
 */
+(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
/**
 北京时间
 什么是UTC？ 世界标准时间，国际协调时间，简称UTC。不属于任意时区
 啥事时间戳？就是1970.1.1 00：00：00作为标准，某个时间和他的秒数，并且NSDate必须是0时区的，UTC格式的
 时间戳应该是10位，如果不巧碰到了13位的，代表着他计算了毫秒，只要删除剪切前十位就行了
 */
+ (NSDate *)dateChangeToGMTNormal:(NSDate *)fromDate
{
    NSDate *date = fromDate;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

/**
 正则匹配手机号

 @param telNumber 电话号码
 @return flag
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
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
/** 获取版本号 */
+(NSString *)getAppVersion
{
    // 当前app的信息
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return app_Version;
}

@end
