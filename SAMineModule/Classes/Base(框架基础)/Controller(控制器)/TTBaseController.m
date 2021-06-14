//
//  TTBaseController.m
//  Travel-Tp
//
//  Created by Curse Tom on 2019/12/7.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "TTBaseController.h"
#import "BYLoadingView.h"
#import "SSGifLoadingView.h"
#import "OCSkeleton.h"
#import "BYSkeletonLoadingView.h"
#import "BYNaviRootController.h"
#import "TTBaseLoadingView.h"

@interface TTBaseController ()
/**
 加载loadingview
 */
@property (nonatomic,strong) BYLoadingView *loading_view;

/**
 gif loading
 */
@property (strong, nonatomic) SSGifLoadingView *gifLoadingView;
/**
 遮罩层
 */
@property (strong, nonatomic) UIView *overlayView;

@end

@implementation TTBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自动分割navibar 和 tabbar 的高度
    [self setAutomaticallyAdjustsScrollViewInsets:true];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    // Do any additional setup after loading the view.
    BYNaviRootController *nav_vc = (BYNaviRootController *)self.navigationController;
    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedButton.width = 0;
    if ([[nav_vc viewControllers] count]>1) {
        UIButton *btn_back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
        [btn_back addTarget:self action:@selector(click_back:) forControlEvents:UIControlEventTouchUpInside];
        [btn_back setImage:[UIImage imageNamed:@"back_navicon_default_controller"] forState:UIControlStateNormal];
        UIBarButtonItem *left_item = [[UIBarButtonItem alloc]initWithCustomView:btn_back];
        [self.navigationItem setLeftBarButtonItems:@[fixedButton,left_item]];
    }
    [self baseConfig];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*
    BYNaviRootController *nav_vc = (BYNaviRootController *)self.navigationController;
    CustomTabVC *tab_vc = (CustomTabVC *)self.tabBarController;
    if ([[nav_vc viewControllers] count]>1) {
        NSLog(@"隐藏tab");
        [tab_vc dismiss_tabview];
    }else{
        NSLog(@"打开tab");
        [tab_vc show_tabview];
    }
     */
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */
-(void)eventEmit:(id)event param:(id)param
{
    !self.emitEvent ?: self.emitEvent(event, param);
}
/**
 配置一些加载项
 */
-(void)baseConfig
{
//    self.view.backgroundColor = LIGHT_GRAY_BG;
//    TTBaseLoadingView *loadingView = [[TTBaseLoadingView alloc]initWithFrame:self.view.bounds];
    BYSkeletonLoadingView *loadingView = [[BYSkeletonLoadingView alloc]initWithFrame:self.view.bounds];
//    RBBaseSkeletonLoadingView *loadingView = [[RBBaseSkeletonLoadingView alloc]initWithFrame:self.view.bounds];
//    loadingView.backgroundColor = self.view.backgroundColor;
//    SSGifLoadingView *loadingView = [[SSGifLoadingView alloc]initWithFrame:self.view.bounds];
    self.view.wy_loadingView = loadingView;
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    [self.view wy_configNullView:^UIView *(NullView *defaultNullView) {
        defaultNullView.backgroundColor = [UIColor colorWithHexString:MAINPAGETHEMECOLORHEX];
        return defaultNullView;
    }];
    [self.view wy_nullViewAddTarget:self action:@selector(clickReloadDataInControllerView:)];
}
/** nullview视图点击事件 交给子类实现*/
-(void)clickReloadDataInControllerView:(UITapGestureRecognizer *)tap{
    
}
/**
 生成跳转STPopupController
*/
-(TTSTPopupController *)generatePopControllerWidthRootController:(UIViewController *)rootController
{
    UIViewController *controller = rootController;
    TTSTPopupController*pop = [[TTSTPopupController alloc] initWithRootViewController:controller];
//    controller.view.backgroundColor = [UIColor clearColor];
    pop.navigationBarHidden= true;
    pop.style = STPopupStyleFormSheet;
    pop.containerView.backgroundColor = [UIColor clearColor];
    pop.backgroundView.userInteractionEnabled = true;
    [pop.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundSTPopViewDidTap:)]];
    return pop;
}
/** 点击popup 背景 */
-(void)backgroundSTPopViewDidTap:(UITapGestureRecognizer *)tap{
    
}
-(UIView *)overlayView{
    if (!_overlayView) {
        _overlayView = [[UIView alloc]initWithFrame:self.view.bounds];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOverlayView:)];
        _overlayView.userInteractionEnabled = true;
        [_overlayView addGestureRecognizer:tap];
    }
    return _overlayView;
}
-(void)tapOverlayView:(UITapGestureRecognizer *)tap
{
    [self overlayTapAction];
}
/**
 点击overlay view 交给子类实现
 */
-(void)overlayTapAction
{
    
}
-(void)showOverlayViewWithBlowView:(UIView *)belowView
{
    [self.view insertSubview:self.overlayView belowSubview:belowView];
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayView.alpha = 0.5;
    }];
}
-(void)dismissOverlayView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.overlayView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.overlayView removeFromSuperview];
        }
    }];
}




-(void)click_back:(UIButton *)btn{
//    [MMPickerView dismissWithCompletion:^(NSString *item, NSUInteger row) {
//
//    }];
    [self.navigationController popViewControllerAnimated:true];
}

-(BYLoadingView *)loading_view{
    if (!_loading_view) {
        _loading_view = [[BYLoadingView alloc]initWithFrame:self.view.bounds type:@"wp8" title:@"正在读取..."];
        
    }
    return _loading_view;

}
-(void)startLoading{
    [self.loading_view setTitle:@"加载中"];
    [self.loading_view showAtView:self.view];
}

-(void)dismissLoading{
    [self.loading_view dismiss];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if ([self.loading_view superview]) {
        [self.loading_view setSize:self.view.size];
        [self.loading_view setLeft:0];
        [self.loading_view setTop:0];
    }
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[SSGifLoadingView class]]) {
            [v setSize:self.view.size];
            [v setLeft:0];
            [v setTop:0];
            break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 顶部状态栏

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
/**
 showInView的圆角
 
 @return CGFloat
 */
-(CGFloat)showInViewCornerRadius{
    return 3;
}

/**
 showInView默认的size
 
 @return CGSize
 */
-(CGSize)showInviewSize{
    return CGSizeMake(YYScreenSize().width*0.95, YYScreenSize().height*0.8);
}

/**
 弹出视图
 
 @param v 父视图
 @param size 显示的size
 @param flag 是否可以点击退出
 */
-(void)showInView:(UIView *)v size:(CGSize)size dismissTouch:(BOOL)flag
{
    [self.view.layer setCornerRadius:[self showInViewCornerRadius]];
    PREPCONSTRAINTS(self.view);
    CGFloat width = CGSizeEqualToSize(size, CGSizeZero) ? [self showInviewSize].width : size.width ;
    CGFloat height = CGSizeEqualToSize(size, CGSizeZero) ? [self showInviewSize].height : size.height;
    CONSTRAIN_SIZE(self.view, width, height);
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:v
                                            showType:(KLCPopupShowType)KLCPopupShowTypeShrinkIn
                                         dismissType:(KLCPopupDismissType)KLCPopupDismissTypeShrinkOut
                                            maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:flag
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    self.popup = popup;
    
}
/**
 生成居中的layout popup弹窗
 @param v 居中的视图
 @param complete 回调
*/
-(void)generateCenterPopupLayoutWithView:(UIView *)v complete:(void(^)(KLCPopupLayout layout, KLCPopup* popup))complete{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutCenter);
    KLCPopup* popup = [KLCPopup popupWithContentView:v
                                            showType:(KLCPopupShowType)KLCPopupShowTypeShrinkIn
                                         dismissType:(KLCPopupDismissType)KLCPopupDismissTypeShrinkOut
                                            maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:true
                               dismissOnContentTouch:NO];
    complete(layout,popup);

}
/**
 生成从底部弹出的layout popup弹窗
 @param v 底部的视图
 @param complete 回调
*/
-(void)generatePopupFromBottomWithView:(UIView *)v complete:(void(^)(KLCPopupLayout layout, KLCPopup* popup))complete{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutBottom);
    KLCPopup* popup = [KLCPopup popupWithContentView:v
                                            showType:(KLCPopupShowType)KLCPopupShowTypeSlideInFromBottom
                                         dismissType:(KLCPopupDismissType)KLCPopupDismissTypeShrinkOut
                                            maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:true
                               dismissOnContentTouch:NO];
    complete(layout,popup);

}
/**
 iOS13 presentViewController 模态全屏适配
*/
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if (@available(iOS 13.0, *)) {
        if (UIModalPresentationPageSheet == viewControllerToPresent.modalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
        }
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
-(CGFloat)safeAreaHeight
{
    if (@available(iOS 11.0, *)) {
        CGFloat safeHeight = self.view.safeAreaLayoutGuide.layoutFrame.size.height;
        return safeHeight;
    } else {
        // Fallback on earlier versions
        return self.view.height;
    }
}
/** 获取顶部navgationBar包含状态栏的高度 */
-(CGFloat)getNavBarHeightIncludeStatusBar
{
    //获取状态栏的rect
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    //获取导航栏的rect
    CGRect navRect = self.navigationController.navigationBar.frame;
    return statusRect.size.height+navRect.size.height;
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
