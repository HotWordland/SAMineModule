//
//  BYNetWorking.m
//  BYLottery
//
//  Created by 情热大陆 on 16/4/7.
//  Copyright © 2016年 Lon. All rights reserved.
//

#import "BYNetWorking.h"


/**
 登录

 @return url
 */
#define getLoginActionUrl()({[NSString stringWithFormat:@"%@/%@/login",REQUESTDOMAIN,Index_Module];})

/**
 验证码

 @return url
 */
#define getCreateVerifyUrl()({[NSString stringWithFormat:@"%@/%@/getCreateVerify",REQUESTDOMAIN,Index_Module];})

/**
 条件查询

 @return url
 */
#define getConditionListUrl()({[NSString stringWithFormat:@"%@/%@/order/getConditionList",REQUESTDOMAIN,Index_Module];})

/**
 更新用户信息
 
 @return url
 */
#define editUserInfoUrl()({[NSString stringWithFormat:@"%@/%@/user/edit",REQUESTDOMAIN,Index_Module];})


@implementation BYNetWorking

+(void)loginWithParamWithUserName:(NSString *)username Password:(NSString *)pwd randomCode:(NSString *)random DymicPassword:(NSString *)optPwd success:(successBlock)success failed:(failedBlock)failed{    
    NSDictionary *theParam = @{@"username":username,@"password":pwd,@"code":optPwd,@"randomCode":random};
    [BYRequest POST:getLoginActionUrl() parameters:theParam defalutRemoteToast:NO
            success:^(NSURLSessionDataTask *task, id responseObject) {
                if (![self codeCheckVaild:responseObject]) {
                    if ([self handleErrorShowTips]) {
                        TOAST_WINDOW([self getRemoteMsg:responseObject]);
                    }
                    failed(nil,BYNET_HANDLE_ERROR_FLAG,[self getRemoteData:responseObject]);
                    return ;
                }
                success([self getRemoteData:responseObject]);
                [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [ProgressHUD dismiss];
        if ([self handleErrorShowTips]) {
            TOAST_WINDOW(BYNET_NETWORK_ERROR_MSG);
        }
        failed(error,BYNET_NETWORK_ERROR_FLAG,nil);
    }];
 }
+(void)createVerifyCodeWithRandom:(NSString *)random success:(successBlock)success failed:(failedBlock)failed{    
    NSDictionary *theParam = @{@"randomCode":random};
    [BYRequest GET:getCreateVerifyUrl() parameters:theParam
            success:^(NSURLSessionDataTask *task, id responseObject) {
                if (![self codeCheckVaild:responseObject]) {
                    if ([self handleErrorShowTips]) {
                        TOAST_WINDOW([self getRemoteMsg:responseObject]);
                    }
                    failed(nil,BYNET_HANDLE_ERROR_FLAG,[self getRemoteData:responseObject]);
                    return ;
                }
                success([self getRemoteData:responseObject]);
                [ProgressHUD dismiss];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [ProgressHUD dismiss];
                if ([self handleErrorShowTips]) {
                    TOAST_WINDOW(BYNET_NETWORK_ERROR_MSG);
                }
                failed(error,BYNET_NETWORK_ERROR_FLAG,nil);
            }];
}
+(void)editUserInfoWithParam:(NSDictionary *)param Success:(successBlock)success failed:(failedBlock)failed{
    [BYRequest POST:editUserInfoUrl() parameters:param defalutRemoteToast:NO
            success:^(NSURLSessionDataTask *task, id responseObject) {
                if (![self codeCheckVaild:responseObject]) {
                    if ([self handleErrorShowTips]) {
                        TOAST_WINDOW([self getRemoteMsg:responseObject]);
                    }
                    failed(nil,BYNET_HANDLE_ERROR_FLAG,[self getRemoteData:responseObject]);
                    return ;
                }
                TOAST_WINDOW([self getRemoteMsg:responseObject]);
                success([self getRemoteData:responseObject]);
                [ProgressHUD dismiss];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [ProgressHUD dismiss];
                if ([self handleErrorShowTips]) {
                    TOAST_WINDOW(BYNET_NETWORK_ERROR_MSG);
                }
                failed(error,BYNET_NETWORK_ERROR_FLAG,nil);
            }];
}

+(void)getConditionListWithSuccess:(successBlock)success failed:(failedBlock)failed{
    [BYRequest POST:getConditionListUrl() parameters:nil defalutRemoteToast:NO
            success:^(NSURLSessionDataTask *task, id responseObject) {
                if (![self codeCheckVaild:responseObject]) {
                    if ([self handleErrorShowTips]) {
                        TOAST_WINDOW([self getRemoteMsg:responseObject]);
                    }
                    failed(nil,BYNET_HANDLE_ERROR_FLAG,[self getRemoteData:responseObject]);
                    return ;
                }
                success([self getRemoteData:responseObject]);
                [ProgressHUD dismiss];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [ProgressHUD dismiss];
                if ([self handleErrorShowTips]) {
                    TOAST_WINDOW(BYNET_NETWORK_ERROR_MSG);
                }
                failed(error,BYNET_NETWORK_ERROR_FLAG,nil);
            }];

}

+(NSString *)generateVerCodeUrlWithRandom:(NSString *)random
{
    
    return [NSString stringWithFormat:@"%@?randomCode=%@",getCreateVerifyUrl(),random];
}

/**
 检查是否返回成功

 @param value 原始数据
 @return flag
 */
+(BOOL)codeCheckVaild:(id)value{
    BOOL flag = NO;
    id code = value[@"code"];
    //无这个键 那么直接返回false
    if (!code) {
        return false;
    }
    NSUInteger codeInterger = [code integerValue];
    if (codeInterger == 0) {
        flag = true;
    } 
    return flag;
}

/**
 获取服务端的信息内容

 @param value 原始数据
 @return 信息
 */
+(NSString *)getRemoteMsg:(id)value
{
    NSString *msg = value[@"message"];
    if (!msg) {
        msg = value[@"msg"];
    }
    return msg;
}

/**
 获取服务端data数据

 @param value 原始数据
 @return 返回内容data
 */
+(id)getRemoteData:(id)value
{
    return value[@"data"];
}

/**
 全局控制是否显示handle错误内容

 @return flag
 */
+(BOOL)handleErrorShowTips
{
    return true;
}
/**
 全局控制是否显示network错误内容
 
 @return flag
 */
+(BOOL)netErrorShowTips
{
    return true;
}
+(BOOL)checkNeedLogin:(id)value
{
//    BOOL needLogin = [value[@"needLogin"] boolValue];
//    if (needLogin) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:CCLoginNotiName object:nil userInfo:@{@"action":@"quite"}];
//            return true;
//        }
    return false;
}

@end
