//
//  BYRequest.m
//  BYLottery
//
//  Created by 情热大陆 on 16/4/7.
//  Copyright © 2016年 Lon. All rights reserved.
//

#import "BYRequest.h"
static NSString * const BYRequestClientURLString = @"https://api.mazigou.cn/";
static NSString * const LYHTTPClientURLString = @"https://api.mazigou.cn/";
//NSString * const LYHTTPClientRequestCache = @"LYHTTPClientRequestCache";
static NSTimeInterval const LYHTTPClientTimeoutInterval = 30;
typedef NS_ENUM(NSUInteger, LYHTTPClientRequestType) {
    LYHTTPClientRequestTypeGET = 0,
    LYHTTPClientRequestTypePOST,
};

@implementation BYRequest
+(NSString*)sortByASCII:(NSDictionary*)dic{
    NSArray* arr = [dic allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        /**
         In the compare: methods, the range argument specifies the
         subrange, rather than the whole, of the receiver to use in the
         comparison. The range is not applied to the search string.  For
         example, [@"AB" compare:@"ABC" options:0 range:NSMakeRange(0,1)]
         compares "A" to "ABC", not "A" to "A", and will return
         NSOrderedAscending. It is an error to specify a range that is
         outside of the receiver's bounds, and an exception may be raised.
         
         - (NSComparisonResult)compare:(NSString *)string;
         
         compare方法的比较原理为,依次比较当前字符串的第一个字母:
         如果不同,按照输出排序结果
         如果相同,依次比较当前字符串的下一个字母(这里是第二个)
         以此类推
         
         排序结果
         NSComparisonResult resuest = [obj1 compare:obj2];为从小到大,即升序;
         NSComparisonResult resuest = [obj2 compare:obj1];为从大到小,即降序;
         
         注意:compare方法是区分大小写的,即按照ASCII排序
         */
        //小写转化
        obj1 = [obj1 lowercaseString];
        obj2 = [obj2 lowercaseString];
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSString *resultStr = @"";
    for(int i=0 ; i<arr.count ; i++)
    {
        //服务端规则 键值需要小写
        NSString *temp = [NSString stringWithFormat:@"%@=%@",[arr[i] lowercaseString],[dic objectForKey:arr[i]]];
        resultStr =  [resultStr stringByAppendingString:temp];
        if(i != arr.count-1){
            resultStr = [resultStr stringByAppendingString:@"&"];
        }
    }
    return resultStr;
}
//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *nParam = [self handleParamsCodeWithParams:parameters];
    return [super GET:URLString parameters:nParam timeoutInterval:LYHTTPClientTimeoutInterval cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:success failure:failure];
}
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
           defalutRemoteToast:(BOOL)toastFlag
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *nParam = [self handleParamsCodeWithParams:parameters];
    return [super GET:URLString parameters:nParam timeoutInterval:LYHTTPClientTimeoutInterval cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        //检查token是否失效 需要重新登录
        if(![BYNetWorking checkNeedLogin:responseObject]){
            if (toastFlag) {
                if (responseObject[@"Description"]) {
                    if (![responseObject[@"Description"] isEqualToString:@""]) {
                        TOAST_WINDOW(responseObject[@"Description"])
                    }
                }
            }
            success(task,responseObject);
            return;
        }
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //避免忘记 dimiss progress
        [ProgressHUD dismiss];
//        [[[UIApplication sharedApplication].delegate window] makeToast:@"请求失败" duration:0.5 position:CSToastPositionCenter];
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *nParam = [self handleParamsCodeWithParams:parameters];
    return [super POST:URLString parameters:nParam timeoutInterval:LYHTTPClientTimeoutInterval cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:success failure:failure];
}
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
            defalutRemoteToast:(BOOL)toastFlag
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *nParam = [self handleParamsCodeWithParams:parameters];
    return [super POST:URLString parameters:nParam timeoutInterval:LYHTTPClientTimeoutInterval cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
        //检查token是否失效 需要重新登录
        if(![BYNetWorking checkNeedLogin:responseObject]){
            if (toastFlag) {
                if (responseObject[@"Description"]) {
                    if (![responseObject[@"Description"] isEqualToString:@""]) {
                        TOAST_WINDOW(responseObject[@"Description"])
                    }
                }
            }
            success(task,responseObject);
            return;
        }
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //避免忘记 dimiss progress
        [ProgressHUD dismiss];
//        [[[UIApplication sharedApplication].delegate window] makeToast:@"请求失败" duration:0.5 position:CSToastPositionCenter];
        if (failure) {
            failure(task, error);
        }
    }];
}
+(NSMutableDictionary *)handleParamsCodeWithParams:(NSDictionary *)params{
    NSString *version = @"1.0";
    NSTimeInterval timestampInterval = [[NSDate date] timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f",timestampInterval];
    NSString *nonce = [NSString stringWithFormat:@"%d",[self getRandomNumber:100000 to:1000000]];
//    User *user = [User ShareUser];
//    NSString *accesskey = user.accesskey ? user.accesskey : @"";
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:@{@"version":version,@"timestamp":timestamp,@"nonce":nonce,@"showType":@"iOS"}];
    [result addEntriesFromDictionary:params];
    return result;
}
+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}
+ (instancetype)client{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    BYRequest *client = [[BYRequest alloc] initWithBaseURL:nil sessionConfiguration:configuration];
//    User *user = [User ShareUser];
//    NSString *Authorization = [NSString stringWithFormat:@"Bearer %@",user.code];
//    [client.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
    NSMutableSet *mgrSet = [NSMutableSet set];
    mgrSet.set = client.responseSerializer.acceptableContentTypes;
    [mgrSet addObject:@"text/html"];
    [mgrSet addObject:@"text/plain"];
    client.responseSerializer.acceptableContentTypes = mgrSet;
    return client;
    
}
+ (instancetype)sharedClient{
    static BYRequest *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [BYRequest client];
        
    });
    return sharedClient;
}
/**
 请求序列化
 在这里进行一些请求头之类的处理
 */
+(void)handleRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer
{
    //    User *user = [User ShareUser];
    //    NSString *Authorization = user.accesskey.length == 0 ? @"" : user.accesskey;
    //    [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"accesskey"];
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
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self handleRequestSerializer:manager.requestSerializer];
    switch (type) {
        case LYHTTPClientRequestTypeGET:{
            return  [manager GET:URLString parameters:parameters headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
                
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
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    //    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    // [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] can be nil and . Crash at NSParameterAssert(URLString) AFURLRequestSerialization.m https://github.com/AFNetworking/AFNetworking/issues/3080 and solution - https://stackoverflow.com/questions/1981390/urlwithstring-returns-nil by stringByAddingPercentEscapesUsingEncoding function
    NSString* webStringURL = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:webStringURL] absoluteString] parameters:parameters error:&serializationError];
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}

/*
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
               timeoutInterval:(NSTimeInterval)timeoutInterval
                   cachePolicy:(LYHTTPClientRequestCachePolicy)cachePolicy
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    User *user = USER;
    NSMutableDictionary *result_params = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    if (user.jsession_id) {
        [result_params addEntriesFromDictionary:@{@"jsessionid":user.jsession_id}];
    }
    return [super POST:URLString parameters:result_params timeoutInterval:timeoutInterval cachePolicy:cachePolicy success:^(NSURLSessionDataTask *task, id responseObject){
        @try {
            if ([responseObject[@"code"] isEqualToString:@"9999"]) {
                //重新登录
                NSString *u_username = user.userName;
                NSString *u_pwd = user.password;
                NSDictionary *params = @{@"do":@"login",
                                         @"passwd":[u_pwd md5String],
                                         @"moibleInfo":@"ios",
                                         @"username":u_username,
                                         @"type":@"1"
                                         };
                [BYNetWorking loginParam:params Success:^(id data) {
                    [BYRequest POST:URLString parameters:parameters timeoutInterval:60 cachePolicy:LYHTTPClientReloadIgnoringLocalCacheData success:^(NSURLSessionDataTask *task, id responseObject) {
                        success(task,responseObject);
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        [ProgressHUD dismiss];
                        TOAST_WINDOW_RETURN_STATUS_FAIL;
                    }];


                } failed:^(NSError *error) {
                   TOAST_WINDOW(@"自动登录失败")
                }];
                
            }else{
                success(task,responseObject);
            }
        } @catch (NSException *exception) {
            TOAST_WINDOW(@"responseObject code 未定义")
        }
    
    } failure:failure];
//    return [super POST:URLString parameters:result_params timeoutInterval:timeoutInterval cachePolicy:cachePolicy success:success failure:failure];
    
}
*/
@end
