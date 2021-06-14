//
//  BYNetWorking+Qiniu.h
//  SA
//
//  Created by Curse Tom on 2021/6/8.
//

#import "BYNetWorking.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYNetWorking (Qiniu)
/**
 获取七牛上传token
 
 @param param 参数
 @param success 成功回调
 @param failed 失败回调
 */
+(void)uptoken:(NSDictionary *)param success:(successBlock)success failed:(failedBlock)failed;
@end

NS_ASSUME_NONNULL_END
