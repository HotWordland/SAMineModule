//
//  CountDown.h
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CountDown : NSObject
///用NSDate日期倒计时
-(void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;
///用时间戳倒计时
-(void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;
///每秒走一次，回调block
-(void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock;
-(void)destoryTimer;
-(NSDate *)dateWithLongLong:(long long)longlongValue;
-(NSInteger)getDayNumberWithYear:(NSInteger )y month:(NSInteger )m;
-(NSString *)getNowTimeWithString:(NSString *)aTimeString;
+(NSString *)getNowTimeWithStringWithTimeInterval:(NSTimeInterval)timeInterval;
-(NSString *)getNowTimeWithStringWithTimeIntervalForInstance:(NSTimeInterval)timeInterval;

/**
 获取截止时间-不包含天数

 @param aTimeString 截止时间
 @return 时间字符
 */
+(NSString *)getNowTimeWithStringNotDays:(NSString *)aTimeString;
@end
