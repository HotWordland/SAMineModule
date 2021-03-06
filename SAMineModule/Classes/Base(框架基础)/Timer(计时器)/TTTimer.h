//
//  TTTimer.h
//  Travel-Tp
//
//  Created by Ryzen on 2020/2/28.
//  Copyright © 2020 Ryzen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 不失精度加减乘除计算
 - OMDecimalOprationTypeAdd: 加
 - OMDecimalOprationTypeSubtract: 减
 - OMDecimalOprationTypeMultiple: 乘
 - OMDecimalOprationTypeDivide: 除
 */
typedef NS_ENUM(NSUInteger, OMDecimalOprationType) {
    OMDecimalOprationTypeAdd,
    OMDecimalOprationTypeSubtract,
    OMDecimalOprationTypeMultiple,
    OMDecimalOprationTypeDivide
};


/**  计时器的时间模型*/
@interface TTTime : NSObject
/** 时-分-秒-毫秒*/
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;
@property (nonatomic, copy) NSString *millisecond;

@end

/** 进度闭包回调*/
typedef void(^OMProgressBlock)(TTTime *progress);
/** 完成闭包回调*/
typedef void(^OMTimerCompletion)(void);

/** 计时器*/
@interface TTTimer : NSObject

/** 计时器是否为增加模式*/
@property (nonatomic, assign) BOOL isAscend;
/** 计时器的计时时间*/
@property (nonatomic, assign) NSTimeInterval timerInterval;
/** 计时器触发的精度，默认为100ms触发一次回调，取值区间为100-1000 */
@property (nonatomic, assign) NSInteger precision;
/** 计时器的回调*/
@property (nonatomic, strong) OMProgressBlock progressBlock;
/** 计时器完成的回调*/
@property (nonatomic, strong) OMTimerCompletion completion;
/** 是否为暂停状态*/
@property (nonatomic, assign, readonly, getter=isSupsending) BOOL suspend;
/** 是否为运行状态*/
@property (nonatomic, assign, readonly, getter=isRuning) BOOL run;
/** 是否为完成状态*/
@property (nonatomic, assign, readonly, getter=isComplete) BOOL complete;
/** 当前时间*/
@property (nonatomic, assign) NSTimeInterval currentTime;


/**
 初始化计时器
 @param timeinterval 计时的时间
 @param isAscend 是否为增加计时
 @param progressBlock 进度回调
 @param completion 倒计时结束回调
 @return 计时器
 */
- (instancetype)initWithStartTimeinterval: (NSTimeInterval)timeinterval isAscend: (BOOL)isAscend progressBlock: (OMProgressBlock)progressBlock completionBlock: (OMTimerCompletion)completion;

/** 开始计时*/
- (void)resume;

/** 暂停计时*/
- (void)suspend;

/** 继续暂停的任务*/
- (void)activate;

/** 停止计时*/
- (void)stop;

/** 重置计时器并开始计时*/
- (void)restart;

/** 不失精度加减乘除计算结果*/
+ (NSDecimalNumber *)value: (NSTimeInterval)value byOpration: (OMDecimalOprationType)byOpration percision: (NSInteger)percision withValue: (NSTimeInterval)withValue;
/**
 结束时间字符串转NSTimeInterval
 @params endTime 结束字符串
*/
+(NSTimeInterval)endTimeConverToInterval:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END
