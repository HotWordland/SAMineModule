//
//  BYNetWorking.h
//  BYLottery
//
//  Created by 情热大陆 on 16/4/7.
//  Copyright © 2016年 Lon. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SAmsrequest.h"

#define Client_Module @"ClientMain"
#define Index_Module @"api/app"

//#ifdef DEBUG
/** 测试服 */
#define REQUESTDOMAIN @"http://www.joyseevip.com"
#define BAGCLOUD_REQUESTDOMAIN @"https://bagcloud-api.cqlyy.com"
#define LJLIVE_REQUESTDOMAIN @"https://ljlive-ts-web.1000fun.com"
#define LJLIVE_SOCKETDOMAIN @"wss://ljlive-ts-websocket.1000fun.com"
//#else
/** 正式服 */
//#define REQUESTDOMAIN @"https://dbss-yunshangcq.1000fun.com"
//#define BAGCLOUD_REQUESTDOMAIN @"https://bagcloud-api.cqlyy.com"
//#define LJLIVE_REQUESTDOMAIN @"https://ljlive-web.1000fun.com"
//#define LJLIVE_SOCKETDOMAIN @"wss://ljlive-websocket.1000fun.com"
//#endif

#define SNACK_REQUESTDOMAIN @"http://snack.landwonder.site"
#define HUB_QUERING @"正在查询"
#define HUB_READING @"正在读取"
#define INSERT_PARM_NIL_ALERT @"操作失败"
#define RESULT_DATA_INVALID_ALERT @"数据异常"
#define RESULT_HANDLE_SUCCESS_ALERT @"操作成功"
#define BYNET_NETWORK_ERROR_MSG @"网络异常"
#define BYNET_NETWORK_ERROROUTRETRY_MSG @"网络异常,请退出重试"
#define SERVER_ERROROUTRETRY_MSG @"服务异常,请退出重试"
#define BYNET_HANDLE_ERROR_FLAG 10001

#define BYNET_NETWORK_ERROR_FLAG 20001


@interface BYNetWorking : NSObject
typedef void(^successBlock)(id data);
typedef void(^failedBlock)(NSError *error,NSUInteger flag,id data);

/**
 登录

 @param username 用户名
 @param pwd 密码
 @param random 随机数
 @param success 成功回调
 @param failed 失败会滴
 */
+(void)loginWithParamWithUserName:(NSString *)username Password:(NSString *)pwd randomCode:(NSString *)random DymicPassword:(NSString *)optPwd success:(successBlock)success failed:(failedBlock)failed;

/**
 获取随机验证码

 @param random 随机码
 @param success 成功回调
 @param failed 失败回调
 */
+(void)createVerifyCodeWithRandom:(NSString *)random success:(successBlock)success failed:(failedBlock)failed;

/**
 生成图片验证码参数

 @param random 随机数
 @return 图片地址
 */
+(NSString *)generateVerCodeUrlWithRandom:(NSString *)random;

/**
 查询订单内容

 @param success 成功
 @param failed 失败
 */
+(void)getConditionListWithSuccess:(successBlock)success failed:(failedBlock)failed;

/**
 编辑用户信息

 @param param password
 @param success 成功回调
 @param failed 失败回调
 */
+(void)editUserInfoWithParam:(NSDictionary *)param Success:(successBlock)success failed:(failedBlock)failed;

/**
 检查是否返回成功
 
 @param value 原始数据
 @return flag
 */
+(BOOL)codeCheckVaild:(id)value;
/**
 获取服务端的信息内容
 
 @param value 原始数据
 @return 信息
 */
+(NSString *)getRemoteMsg:(id)value;
/**
 获取服务端data数据
 
 @param value 原始数据
 @return 返回内容data
 */
+(id)getRemoteData:(id)value;
/**
 全局控制是否显示handle错误内容
 
 @return flag
 */
+(BOOL)handleErrorShowTips;
/**
 全局控制是否显示network错误内容
 
 @return flag
 */
+(BOOL)netErrorShowTips;

/**
 检查重新登录内容

 @param value 数据
 */
+(BOOL)checkNeedLogin:(id)value;

@end
