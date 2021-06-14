//
//  BYJsonRequest.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/5/31.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BYJsonRequest.h"

static NSTimeInterval const LYHTTPClientTimeoutInterval = 30;
typedef NS_ENUM(NSUInteger, LYHTTPClientRequestType) {
    LYHTTPClientRequestTypeGET = 0,
    LYHTTPClientRequestTypePOST,
};
@implementation BYJsonRequest

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [super POST:URLString parameters:parameters timeoutInterval:LYHTTPClientTimeoutInterval cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:success failure:failure];
}
+ (NSURLSessionDataTask *)requestMethod:(LYHTTPClientRequestType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                        timeoutInterval:(NSTimeInterval)timeoutInterval
                                  cache:(YYCache *)cache
                               cacheKey:(NSString *)cacheKey
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    BYRequest *manager = [BYRequest performSelector:@selector(sharedClient)];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    User *user = [User ShareUser];
//    NSString *Authorization = user.accesskey.length == 0 ? @"" : user.accesskey;
//    [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"accesskey"];
    switch (type) {
        case LYHTTPClientRequestTypeGET:{
            return [manager GET:URLString parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                DLog(@"request params is %@",parameters);
                DLog(@"request response is %@",responseObject);
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
            break;
        }
        case LYHTTPClientRequestTypePOST:{
            return [manager POST:URLString parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                }
                [cache setObject:responseObject forKey:cacheKey];//YYCache 已经做了responseObject为空处理
                DLog(@"request params is %@",parameters);
                DLog(@"request response is %@",responseObject);
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
            break;
        }
        default:
            break;
    }
    
}
@end
