//
//  SAmsrequest.m
//  SA
//
//  Created by Ryzen on 2021/6/10.
//

#import "SAmsrequest.h"

@implementation SAmsrequest
+ (instancetype)client{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    SAmsrequest *client = [[SAmsrequest alloc] initWithBaseURL:nil sessionConfiguration:configuration];
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
    static SAmsrequest *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [SAmsrequest client];
        
    });
    return sharedClient;
}

/**
 请求序列化
 在这里进行一些请求头之类的处理
 */
+(void)handleRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer
{
    SAmsrequest *sclient = [SAmsrequest sharedClient];
    if (sclient.token){
        [requestSerializer setValue:sclient.token forHTTPHeaderField:@"token"];
    }
}

@end
@interface BYRequest ()
//sa服务端请求授权的token
@property (copy, nonatomic,readwrite) NSString *token;
@end
/**
  设置api授权访问的token
 */
const char tokenKey;
@implementation BYRequest (SArequest)

//set
-(void)setToken:(NSNumber *)curInSegmentIndex{
    objc_setAssociatedObject(self, &tokenKey, curInSegmentIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
- (NSString *)token{
    return objc_getAssociatedObject(self, &tokenKey);
}

@end
