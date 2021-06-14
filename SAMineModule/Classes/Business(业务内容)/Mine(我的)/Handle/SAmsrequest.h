//
//  SAmsrequest.h
//  SA
//
//  Created by Ryzen on 2021/6/10.
//

#import "BYRequest.h"

NS_ASSUME_NONNULL_BEGIN
//mine模块的请求基础类
@interface SAmsrequest : BYRequest
//sa服务端请求授权的token
@property (copy, nonatomic,readwrite) NSString *token;

@end

NS_ASSUME_NONNULL_END
