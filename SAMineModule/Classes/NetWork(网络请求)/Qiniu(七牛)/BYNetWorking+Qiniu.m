//
//  BYNetWorking+Qiniu.m
//  SA
//
//  Created by Curse Tom on 2021/6/8.
//

#import "BYNetWorking+Qiniu.h"

@implementation BYNetWorking (Qiniu)
/**
 获取七牛上传token
 
 @return url
 */
#define uptokenUrl()({[NSString stringWithFormat:@"%@/fate/api/qiniu/upToken",REQUESTDOMAIN];})
/**
 获取七牛上传token
 
 @param param 参数
 @param success 成功回调
 @param failed 失败回调
 */
+(void)uptoken:(NSDictionary *)param success:(successBlock)success failed:(failedBlock)failed{
    [SAmsrequest GET:uptokenUrl() parameters:param defalutRemoteToast:true
            success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![self codeCheckVaild:responseObject]) {
            if ([self handleErrorShowTips]) {
                TOAST_WINDOW([self getRemoteMsg:responseObject]);
            }
            failed(nil,BYNET_HANDLE_ERROR_FLAG,[self getRemoteData:responseObject]);
            return ;
        }
        id data = responseObject[@"data"];
        success(data);
        [ProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [ProgressHUD dismiss];
        if ([self handleErrorShowTips]) {
            TOAST_WINDOW(BYNET_NETWORK_ERROR_MSG);
        }
        failed(error,BYNET_NETWORK_ERROR_FLAG,nil);
    }];
}

@end
