//
//  SAWebModuleHandle.h
//  SA
//
//  Created by Ryzen on 2021/6/8.
//

#import <Foundation/Foundation.h>
@import WebKit;

NS_ASSUME_NONNULL_BEGIN
/**
 web模块/app 处理层
 */
@interface SAWebModuleHandle : BaseHandle
/** web 视图*/
@property (weak, nonatomic) WKWebView *webView;
/** 所在的控制器 */
@property (weak, nonatomic) UIViewController *controller;
/** 登录的用户id */
@property (copy, nonatomic) NSString *userId;
/** 登录的用户token */
@property (copy, nonatomic) NSString *token;
/** 登录的用户获取到的imghomeurl 图片域名 */
@property (copy, nonatomic) NSString *imghomeurl;
/**
 发送信息
 @param handleid 回调webmodule id
 @param params 回调参数
*/
-(void)sendMessage:(NSString *)handleid params:(NSDictionary *)params;
/** 处理方法 */
-(void)handleWithContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
//获取webmodule 过来的callbackid
-(NSString *)getCallbackid:(id)params;

@end

NS_ASSUME_NONNULL_END
