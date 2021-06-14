//
//  SAMineController.m
//  SA
//
//  Created by Curse Tom on 2021/5/9.
//

#define kdevNetHost @"172.16.6.1:9528"
#define kdevUserid @"1891800"
#define kdevToken @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbi0xODkxODAwIiwiaWF0IjoxNjE5MDIyOTMxLCJleHAiOjE2MjY3OTg5OTF9.Ezr1GKt1R_GgGSoP7FS0U0X5cknZA24PMugKCHJFOEHmtDnyaAWJF1-_5GuprcueivOSPHiTtFwdP8ViaAcwgw"
#define kdevimghomeurl @"http://91sjdj.com"

#import "SAMineController.h"
@import WebKit;
#import "SAWebModuleHandle.h"

@interface SAMineController ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView* webView;
/** 返回标识 */
@property (strong, nonatomic,nullable) WKNavigation* backNavigation;
/** webm 处理 */
@property (strong, nonatomic) SAWebModuleHandle *webmhandle;

@end

@implementation SAMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"323232"];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"ffffff"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"]}];
    PREPCONSTRAINTS(self.webView);
    ALIGN_LEFT(self.webView, 0);
    ALIGN_RIGHT(self.webView, 0);
    ALIGN_TOP(self.webView, 0);
    ALIGN_SAFEAREA_BOTTOM(self.webView, 0);
    [self loadRemoteUrl];
}
#pragma mark - get
-(WKWebView *)webView{
    if (!_webView) {
        //设置跨域
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        if (@available(iOS 10.0, *)) {
             [config setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
        }
        config.userContentController = [WKUserContentController new];
        [config.userContentController addScriptMessageHandler:self name:@"cohandler"];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
-(SAWebModuleHandle *)webmhandle{
    if (!_webmhandle){
        _webmhandle = [SAWebModuleHandle new];
        _webmhandle.controller = self;
        //因为需要单独做成模块导出
        //这里的信息就做成开放接口不与自己的系统用户机制绑定
        _webmhandle.userId = kdevUserid;
        _webmhandle.token = kdevToken;
        _webmhandle.imghomeurl = kdevimghomeurl;
    }
    return _webmhandle;
}
#pragma mark - method
/**
 加载本地web
 */
-(void)loadLocalWeb
{
    NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"samineweb" ofType:@"bundle"];
    //传递参数
    NSString *query = FORMAT_STRING(@"#/mine?token=%@&imghomeurl=%@&userid=%@",kdevToken,kdevimghomeurl,kdevUserid);
    NSURL *fileUrl = [NSURL URLWithString:query relativeToURL:[NSURL fileURLWithPath:[bundleFile stringByAppendingString:@"/dist/index.html"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    [self.webView loadRequest:request];
}
-(void)loadRemoteUrl{
    NSString *urlStr = FORMAT_STRING(@"http://%@#/mine?token=%@&imghomeurl=%@&userid=%@",kdevNetHost,kdevToken,kdevimghomeurl,kdevUserid) ;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
#pragma mark - 拦截点击导航返回
-(void)click_back:(UIButton *)btn{
    if ([self.webView canGoBack]) {
        self.backNavigation = [self.webView goBack];
    }else {
        return [super click_back:btn];
    }
}
#pragma mark - WKNavigationDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.view wy_startLoding];
}
#pragma mark - 导航完成回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.view wy_stopLoding];
    if ([self.backNavigation isEqual:navigation]) {
        // 这次的加载是点击返回产生的，刷新
        [self.webView reload];
        self.backNavigation = nil;
   }
}
#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.webmhandle handleWithContentController:userContentController didReceiveScriptMessage:message];
}

@end
