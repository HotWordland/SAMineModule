//
//  SAWebModuleHandle.m
//  SA
//
//  Created by Ryzen on 2021/6/8.
//

#import "SAWebModuleHandle.h"
#import "SAMineController.h"
#import "SAWebModuleHandle+SelPhotoUploQiniu.h"

@interface SAWebModuleHandle()

@end
@implementation SAWebModuleHandle
#pragma mark - get
-(WKWebView *)webView{
    if (!_webView){
        SAMineController *vc = (SAMineController *)self.controller;
        _webView = [vc valueForKey:@"webView"];
    }
    return _webView;
}
#pragma mark - set
-(void)setToken:(NSString *)token{
    _token = token;
    NSString *method = @"sharedClient";
    SEL mselector = NSSelectorFromString(method);
    SAmsrequest *sclient = [SAmsrequest performSelector:mselector];
    sclient.token = _token;
}
#pragma mark - method
-(NSString *)getCallbackid:(id)params
{
    return params[@"id"];
}
#pragma mark - web module
/**
 发送信息
 @param handleid 回调webmodule id
 @param params 回调参数
*/
-(void)sendMessage:(NSString *)handleid params:(NSDictionary *)params
{
    if (!handleid){
        TOAST_WINDOW(@"未获取到handleid");
        return;
    }
    NSDictionary *tparams = params;
    NSString *tparamsjstr = tparams.jsonStringEncoded;
    NSString *evjs = FORMAT_STRING(@"window.onMessageReceive(\"%@\",%@);",handleid,tparamsjstr);
    [self.webView evaluateJavaScript:evjs completionHandler:^(id _Nullable d, NSError * _Nullable error) {
        if (d){
            DLog(@"%@",d);
        }
    }];

}
/** 处理web module 过来的消息 */
-(void)handleWithContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"cohandler"]){
        NSDictionary *params = message.body;
        DLog(@"%@",params);
        NSDictionary *data = params[@"data"];
        NSString *method = data[@"method"];
        if (!method){
            TOAST_WINDOW(@"未接收到wmodule method");
            return;
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SAWebModuleHandle" ofType:@"plist"];
        NSDictionary *pDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSDictionary *remDic = pDic[@"relative_method"];
        NSString *methodInpic = [remDic valueForKey:method];
        if (!methodInpic){
            TOAST_WINDOW(FORMAT_STRING(@"无此 %@ native method",methodInpic));
            return;
        }
        /** 反射配置的方法调用 */
        Class granny = self.class;
        SEL mselector = NSSelectorFromString(methodInpic);
        IMP grannyImp = class_getMethodImplementation(granny, mselector);
        ((void(*)(id, SEL, id))grannyImp)(self, mselector, params);
    }
}
    
@end
