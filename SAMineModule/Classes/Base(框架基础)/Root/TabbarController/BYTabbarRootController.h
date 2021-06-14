//
//  BYTabbarRootController.h
//  ThroughTrafficBus
//
//  Created by 巫龙 on 2018/1/15.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYTabbarRootController : UITabBarController
/**
 tabbar items集合
 */
@property (strong, nonatomic) NSArray* tabbarItemList;
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
                                    tag:(NSUInteger)tag;

@end
