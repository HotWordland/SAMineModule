//
//  BYTabbarRootController.m
//  ThroughTrafficBus
//
//  Created by 巫龙 on 2018/1/15.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "BYTabbarRootController.h"
#import "BYNaviRootController.h"
#import "SSTabbar.h"

@interface BYTabbarRootController ()<UIActionSheetDelegate>

@end

@implementation BYTabbarRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self checkIsNeedToAuth];
//    });
    
}
-(void)dealloc{
    DLog(@"%@ - dealloc",NSStringFromClass([self class]));
}

/**
 获取tabbaritems

 @return list
 */
-(NSArray *)tabbarItemList
{
    if (!_tabbarItemList) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TabbarItems" ofType:@"plist"];
        NSDictionary *info = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
        NSArray *list = info[@"list"];
        _tabbarItemList = list;
    }
    return _tabbarItemList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载开始
- (void)setUp
{
    for (NSUInteger i = 0; i < self.tabbarItemList.count; i++) {
        NSDictionary *item = self.tabbarItemList[i];
        NSString *name = item[@"name"];
        NSString *iconNomal = item[@"icon"];
        NSString *iconSel = item[@"icon_sel"];
        NSString *className = item[@"className"];
        BOOL xibLoad = [item[@"xibLoad"] boolValue];
        [self addChildViewControllerWithTitle:name className:className xibLoad:xibLoad icon:iconNomal SelectedIcon:iconSel originalData:item tag:1000+i];
    }
    SSTabbar *tabBar = [[SSTabbar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    @weakify(self);
    [tabBar setCenterBarBtnClickBlock:^{
        @strongify(self);
        self.selectedIndex = 1;
    }];
}

/**
 添加子控制器

 @param title 标题
 @param className 类名
 @param isXib 是否为xib加载
 @param icon tabbar 正常图标
 @param icon_pre tabbar 高亮图标
 */
- (void)addChildViewControllerWithTitle:(NSString *)title
                         className:(NSString *)className
                                xibLoad:(BOOL)isXib
                                   icon:(NSString *)icon
                           SelectedIcon:(NSString *)icon_pre
                             originalData:(NSDictionary *)originalData
                                    tag:(NSUInteger)tag
{
    UIViewController *vc ;
    vc = isXib ? [[NSClassFromString(className) alloc]initWithNibName:className bundle:[NSBundle mainBundle]] : [[NSClassFromString(className) alloc]init];
    BYNaviRootController *nav = [[BYNaviRootController alloc]initWithRootViewController:vc];
    nav.title = originalData[@"title"];
    UIImage *iconImage = [UIImage imageNamed:icon];
    UIImage *iconSelectedImage = [UIImage imageNamed:icon_pre];
    iconImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    iconSelectedImage = [iconSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:iconImage selectedImage:iconSelectedImage];
    tabbarItem.title = title;
    nav.tabBarItem = tabbarItem;    
    //selected tint color
    [[UITabBar appearance] setTintColor:[UIColor greenColor]];
    
    //text tint color RGBACOLOR(36, 144, 163, 1)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHexString:[self foregroundColorAttributeColorHex]] }
                                             forState:UIControlStateSelected];
    
    //background tint color
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //RGBACOLOR(93, 189, 184, 1)
    nav.tabBarItem.tag = tag;
    [self addChildViewController:nav];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        nav.tabBarItem.title = title;
    });

}
/**
 返回tabbar标题的颜色
 */
-(NSString *)foregroundColorAttributeColorHex
{
    return @"#31CC90";
}

@end
