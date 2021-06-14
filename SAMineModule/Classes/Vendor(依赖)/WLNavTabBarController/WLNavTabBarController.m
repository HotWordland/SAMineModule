//
//  YPNavTabBarController.m
//  YPNavTabBarController
//
//  Created by 巫龙 on 15/9/24.
//  Copyright (c) 2015年 巫龙. All rights reserved.
//

#import "WLNavTabBarController.h"
#import "WLNavTabBarControllerConst.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (nonatomic, strong, readwrite) WLNavTabBarController* navTabBarController;

@end

@interface WLNavTabBarController () <YPNavTabBarDelegate, UIScrollViewDelegate>



@end

@implementation WLNavTabBarController

#pragma mark - lazy
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
- (UIScrollView*)mainView
{
    if (_mainView == nil) {
        UIScrollView* mainView = [[UIScrollView alloc] init];
        mainView.frame = CGRectMake(0, CGRectGetMaxY(self.navTabBar.frame), self.view.width, self.view.height - CGRectGetMaxY(self.navTabBar.frame));
        mainView.pagingEnabled = YES;
        mainView.bounces = NO;
        mainView.showsHorizontalScrollIndicator = NO;
        mainView.contentSize = CGSizeMake(self.view.width * self.subViewControllers.count, 0);
        mainView.delegate = self;
        [self.view addSubview:mainView];
        self.mainView = mainView;
    }
    return _mainView;
}

- (WLNavTabBar*)navTabBar
{
    if (_navTabBar == nil) {
        WLNavTabBar* navTabBar = [[WLNavTabBar alloc] init];
        navTabBar.frame = CGRectMake(0, 0, self.view.width, [self navTabBarHeight]);
        navTabBar.delegate = self;
        navTabBar.itemTitles = _titles;
        // 更新选项条标题数据
        [navTabBar updateData];
        [self.view addSubview:navTabBar];
        self.navTabBar = navTabBar;
    }
    return _navTabBar;
}
-(CGFloat)navTabBarHeight{
    return 42;
}
#pragma mark - 初始化

- (void)addParentController:(UIViewController*)viewController
{
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (instancetype)initWithParentViewController:(UIViewController*)parentViewController
{
    if (self = [super init]) {
        parentViewController.navTabBarController = self;
        parentViewController.automaticallyAdjustsScrollViewInsets = NO;
        [parentViewController addChildViewController:self];
        if (@available(iOS 11.0, *)) {
            CGFloat height = parentViewController.view.safeAreaLayoutGuide.layoutFrame.size.height;
            self.view.height = height;
        }else{
            CGFloat height = parentViewController.view.size.height;
            self.view.height = height;
        }
        self.view.width = parentViewController.view.width;
        [parentViewController.view addSubview:self.view];
    }
    return self;
}

- (void)setup
{
    // 初始化选项卡标题数组
    self.titles = [[NSMutableArray alloc] initWithCapacity:self.subViewControllers.count];

    for (UIViewController* viewController in self.subViewControllers) {
        [self.titles addObject:viewController.title];
    }

    // 默认navBar高度为0
    _navTabBar_Y = 0;
}

- (void)setSubViewControllers:(NSArray*)subViewControllers
{
    if (!subViewControllers || subViewControllers.count == 0) return;
    _subViewControllers = subViewControllers;
    // 初始化基本信息
    [self setup];
    // 初始化选项条
    [self navTabBar];
    // 初始化滚动主视图
    [self mainView];
    // 开启KVO监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.mainView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    [self.view bringSubviewToFront:self.navTabBar];
    [self.mainView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark - viewDidLoad &dealloc
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)dealloc
{
    @try {
        [self.mainView removeObserver:self forKeyPath:@"contentOffset"];
    }
    @catch (NSException *exception) {
        NSLog(@"mainView removeObserver exception");
    }
}

#pragma mark - KVO
/**
 核心逻辑
 通过contentOffset 来计算改变顶部导航的 progress 从而刷新显示navTab效果
 并且将对应的children controller 和 它的view 添加到 self.controller 和 self.mainView 中
*/
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    UIScrollView* scrollView = (UIScrollView*)object;

    if ([keyPath isEqualToString:@"contentOffset"] && object == self.mainView) {

        _currentIndex = scrollView.contentOffset.x / (self.view.width + 1);

        // 左方目前的index
        int leftCurrentIndex = scrollView.contentOffset.x / (self.view.width - 1);

        self.navTabBar.currentItemIndex = _currentIndex;

        CGFloat progress = scrollView.contentOffset.x / self.view.width;
        self.navTabBar.progress = progress;

        // 加载子视图
        [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
            if (_startContentOffsetX < scrollView.contentOffset.x) {
                if (_currentIndex >= idx) {
                    return;
                }
                UIViewController* vc = (UIViewController*)self.subViewControllers[_currentIndex + 1];
                vc.view.frame = CGRectMake(self.view.width * (_currentIndex + 1), 0, self.view.width, self.mainView.height);
                [self scrollMonitorAddController:vc];
//                [self.mainView addSubview:vc.view];
//                [self addChildViewController:vc];
            }
            else if (_startContentOffsetX > scrollView.contentOffset.x) {
                UIViewController* vc = (UIViewController*)self.subViewControllers[leftCurrentIndex];
                vc.view.frame = CGRectMake(self.view.width * leftCurrentIndex, 0, self.view.width, self.mainView.height);
                [self scrollMonitorAddController:vc];
            }
            //初始化的时候
            else if (_startContentOffsetX == 0 && scrollView.contentOffset.x == 0){
                UIViewController* vc = (UIViewController*)self.subViewControllers[0];
                vc.view.frame = CGRectMake(self.view.width * 0, 0, self.view.width, self.mainView.height);
                [self scrollMonitorAddController:vc];
            }
        }];
    }
}
-(NSInteger)getCurrentScrollIndex{
    return self.mainView.contentOffset.x / (self.view.width - 1);
}
/**
 这里仅仅是扩展一下 供子类好重写

 @param controller 子vc
 */
-(void)scrollMonitorAddController:(UIViewController *)controller
{
    [self.mainView addSubview:controller.view];
    [self addChildViewController:controller];

}
-(void)refreshOffsetHandle
{
    
        UIScrollView *scrollView = self.mainView;
        _currentIndex = scrollView.contentOffset.x / (self.view.width + 1);
    
        // 左方目前的index
        int leftCurrentIndex = scrollView.contentOffset.x / (self.view.width - 1);
    
        _navTabBar.currentItemIndex = _currentIndex;
    
        CGFloat progress = scrollView.contentOffset.x / self.view.width;
    
        _navTabBar.progress = progress;
    
        // 加载子视图
        [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
            if (_startContentOffsetX < scrollView.contentOffset.x) {
                if (_currentIndex >= idx) {
                    return;
                }
                UIViewController* vc = (UIViewController *)self.subViewControllers[_currentIndex + 1];
                vc.view.frame = CGRectMake(self.view.width * (_currentIndex + 1), 0, self.view.width, self.mainView.height);
                [self.mainView addSubview:vc.view];
                [self addChildViewController:vc];
            }
            else if (_startContentOffsetX > scrollView.contentOffset.x) {
                
                UIViewController* vc = (UIViewController*)self.subViewControllers[leftCurrentIndex];
                vc.view.frame = CGRectMake(self.view.width * leftCurrentIndex, 0, self.view.width, self.mainView.height);
                [self.mainView addSubview:vc.view];
                [self addChildViewController:vc];
            }
        }];    
}
#pragma mark - YPNavTabBarDelegate
/**
 这是核心的联动逻辑
 顶部导航的按钮点击后会调用此函数
 该函数会设置mainview 的 contentOffset 属性
 然后会触发mainview的contentOffset kvo监听 observeValueForKeyPath
*/
- (void)itemDidSelectedWithIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index
{
    if (index > self.subViewControllers.count -1 || self.subViewControllers.count == 0) {
        return;
    }
    //相当于点击顶部的按钮后切换tab通知content controller的效果 另外画如果是需要滑动结束后也能通知到content controller 可以参考SSNaughtySegController中的实现
    [self.subViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([(NSObject *)obj respondsToSelector:@selector(segmentContainerDidEndSegment:)]) {
            [(NSObject *)obj performSelector:@selector(segmentContainerDidEndSegment:) withObject:@(index)];
        }
    }];
    if (self.mainView.contentOffset.x!=index * self.view.width) {
        UIViewController* selectedVc = (UIViewController*)self.subViewControllers[index];
        selectedVc.view.frame = CGRectMake(self.view.width * index, 0, self.view.width, self.mainView.frame.size.height);
        [self.mainView addSubview:selectedVc.view];
        [self addChildViewController:selectedVc];
        [self.mainView setContentOffset:CGPointMake(index * self.view.width, 0) animated:NO];
    }else{
        //这个条件是用来防止第一次进来的时候 self.mainView.contentOffset.x 默认就是0
        //所以会影响到 index-0 这个controller.view 不会被加载显示出来
        if (index == 0) {
            UIViewController* selectedVc = (UIViewController *)self.subViewControllers[index];
            if (!selectedVc.view.superview) {                
                selectedVc.view.frame = CGRectMake(self.view.width * index, 0, self.view.width, self.mainView.frame.size.height);
                //这里刚初始化index-0的时候 不加延时 [view wy_startLoading] 会出现毫秒级的错位
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.mainView addSubview:selectedVc.view];
                });
                [self addChildViewController:selectedVc];
            }
        }
    }
}
- (void)progressDidSelectedWithIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index{
    //给需要的子类提供接口
    [self segmentGoIndex:navTabBar index:index];

    
}
- (void)progressDidNotSelectedWithIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index{
    //给需要的子类提供接口
    [self segmentNotGoIndex:navTabBar index:index];
    
}

/**
 交给子类实现需要的内容

 @param navTabBar 导航segment
 @param index 当前active 的 index
 */
-(void)segmentGoIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index{
    
}
/**
 交给子类实现需要的内容
 
 @param navTabBar 导航segment
 @param index 当前active 的 index
 */
-(void)segmentNotGoIndex:(WLNavTabBar*)navTabBar index:(NSInteger)index{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{ // 记录拖动前的起始坐标

    _startContentOffsetX = scrollView.contentOffset.x;
}

#pragma mark - Public
- (void)setNavTabBar_Y:(CGFloat)navTabBar_Y
{
    _navTabBar_Y = navTabBar_Y;

    self.navTabBar.wl_y = navTabBar_Y;
    CGFloat height = self.view.height;
    self.mainView.frame = CGRectMake(0, CGRectGetMaxY(self.navTabBar.frame), self.view.width, height - CGRectGetMaxY(self.navTabBar.frame));
}

- (void)setContentViewH:(CGFloat)contentViewH
{
    _contentViewH = contentViewH;

    _mainView.wl_height = contentViewH;
}

- (void)setNavTabBar_color:(UIColor*)navTabBar_color
{
    navTabBar_color = navTabBar_color;

    self.navTabBar.navgationTabBar_color = navTabBar_color;
}

- (void)setNavTabBarLine_color:(UIColor*)navTabBarLine_color
{
    _navTabBarLine_color = navTabBarLine_color;

    self.navTabBar.navgationTabBar_lineColor = navTabBarLine_color;
}

- (void)setNavTabBar_normalTitle_color:(UIColor*)navTabBar_normalTitle_color
{
    _navTabBar_normalTitle_color = navTabBar_normalTitle_color;

    self.navTabBar.navTabBar_normalTitle_color = navTabBar_normalTitle_color;
}

- (void)setNavTabBar_selectedTitle_color:(UIColor*)navTabBar_selectedTitle_color
{
    _navTabBar_selectedTitle_color = navTabBar_selectedTitle_color;

    self.navTabBar.navTabBar_selectedTitle_color = navTabBar_selectedTitle_color;
}

- (void)setNavTabBar_type:(WLNavTabBarType)navTabBar_type
{
    _navTabBar_type = navTabBar_type;

    self.navTabBar.type = navTabBar_type;
}

- (void)setNavTabBar_style:(WLNavTabBarStyle)navTabBar_style
{
    _navTabBar_style = navTabBar_style;

    self.navTabBar.style = navTabBar_style;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex < 0 || currentIndex >= self.subViewControllers.count)
        return;

    _currentIndex = currentIndex;

    self.navTabBar.progress = currentIndex;
}

@end

@implementation UIViewController (YPNavTabBarControllerItem)

const char key;
/**
  设置当前controller 在 segmentController 中的下标
*/
const char curinSegmentIndexKey;

- (void)setNavTabBarController:(WLNavTabBarController*)navTabBarController
{
    objc_setAssociatedObject(self, &key, navTabBarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (WLNavTabBarController*)navTabBarController
{
    return objc_getAssociatedObject(self, &key);
}
//set
-(void)setCurInSegmentIndex:(NSNumber *)curInSegmentIndex{
    objc_setAssociatedObject(self, &curinSegmentIndexKey, curInSegmentIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
- (NSNumber *)curInSegmentIndex{
    return objc_getAssociatedObject(self, &curinSegmentIndexKey);
}
@end
