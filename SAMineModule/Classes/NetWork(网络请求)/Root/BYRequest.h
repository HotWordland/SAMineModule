//
//  BYRequest.h
//  BYLottery
//
//  Created by 情热大陆 on 16/4/7.
//  Copyright © 2016年 Lon. All rights reserved.
//

#import <WLKit/WLKit.h>

@interface BYRequest : LYHTTPClient

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
           defalutRemoteToast:(BOOL)toastFlag
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                    parameters:(id)parameters
            defalutRemoteToast:(BOOL)toastFlag
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 ASCII排序
 
 @param dic 参数
 @return 排序后的参数
 */
+(NSString*)sortByASCII:(NSDictionary*)dic;
/**
 处理参数增加code的逻辑
 
 @param parameters 参数
 @return NSMutableDictionary
 */
+(NSMutableDictionary *)handleParamsCodeWithParams:(id)parameters;

//获取当前时间戳
+ (NSString *)currentTimeStr;

@end
