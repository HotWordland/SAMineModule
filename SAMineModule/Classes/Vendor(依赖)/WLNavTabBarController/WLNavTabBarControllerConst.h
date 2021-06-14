#import "UIView+WLNavTabBar.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if DEBUG

#define WLLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define WLLog(FORMAT, ...) nil

#endif

/** navgationbar's height */
#define WLNavigationBarH 144.0f
/** statusbar's height */
#define WLStatusBarH 20.0f
/** navtabbar's height and statusbar's height */
#define WLStatusBarHAndNavBarH 64.0f
/** tabbar's height */
#define WLTabBarH 49.0f

/** NotificationCenter */
#define WLNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - Shortcut for Screen's parameter

#define WLScreen [UIScreen mainScreen]
#define WLScreenW [UIScreen mainScreen].bounds.size.width
#define WLScreenH [UIScreen mainScreen].bounds.size.height
#define WLScreenBounds [UIScreen mainScreen].bounds
#define WLScreenScale [UIScreen mainScreen].scale

#pragma mark - Shortcut for Color

#define WLBlackColor [UIColor blackColor]
#define WLBlueColor [UIColor blueColor]
#define WLRedColor [UIColor redColor]
#define WLWhiteColor [UIColor whiteColor]
#define WLGrayColor [UIColor grayColor]
#define WLDarkGrayColor [UIColor darkGrayColor]
#define WLLightGrayColor [UIColor lightGrayColor]
#define WLGreenColor [UIColor greenColor]
#define WLCyanColor [UIColor cyanColor]
#define WLYellowColor [UIColor yellowColor]
#define WLMagentaColor [UIColor magentaColor]
#define WLOrangeColor [UIColor orangeColor]
#define WLPurpleColor [UIColor purpleColor]
#define WLBrownColor [UIColor brownColor]
#define WLClearColor [UIColor clearColor]

/** RGB颜色 */
#define WLColor_RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define WLColor_RGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define WLColor_RGBA_256(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 255.0]
/** 随机色 */
#define WLRandomColor_RGB WLColor_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define WLRandomColor_RGBA WLColor_RGBA_256(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#pragma mark - Shortcut for Font

#define WLFontBold_10 [UIFont boldSystemFontOfSize:10]
#define WLFontBold_11 [UIFont boldSystemFontOfSize:11]
#define WLFontBold_12 [UIFont boldSystemFontOfSize:12]
#define WLFontBold_13 [UIFont boldSystemFontOfSize:13]
#define WLFontBold_14 [UIFont boldSystemFontOfSize:14]
#define WLFontBold_15 [UIFont boldSystemFontOfSize:15]
#define WLFontBold_16 [UIFont boldSystemFontOfSize:16]
#define WLFontBold_17 [UIFont boldSystemFontOfSize:17]
#define WLFontBold_18 [UIFont boldSystemFontOfSize:18]
#define WLFontBold_19 [UIFont boldSystemFontOfSize:19]
#define WLFontBold_20 [UIFont boldSystemFontOfSize:20]
#define WLFontBold_21 [UIFont boldSystemFontOfSize:21]
#define WLFontBold_22 [UIFont boldSystemFontOfSize:22]
#define WLFontBold_23 [UIFont boldSystemFontOfSize:23]
#define WLFontBold_24 [UIFont boldSystemFontOfSize:24]
#define WLFontBold_25 [UIFont boldSystemFontOfSize:25]
#define WLFontBold_26 [UIFont boldSystemFontOfSize:26]
#define WLFontBold_27 [UIFont boldSystemFontOfSize:27]
#define WLFontBold_28 [UIFont boldSystemFontOfSize:28]
#define WLFontBold_29 [UIFont boldSystemFontOfSize:29]
#define WLFontBold_30 [UIFont boldSystemFontOfSize:30]

#define WLFontSystem_10 [UIFont systemFontOfSize:10]
#define WLFontSystem_11 [UIFont systemFontOfSize:11]
#define WLFontSystem_12 [UIFont systemFontOfSize:12]
#define WLFontSystem_13 [UIFont systemFontOfSize:13]
#define WLFontSystem_14 [UIFont systemFontOfSize:14]
#define WLFontSystem_15 [UIFont systemFontOfSize:15]
#define WLFontSystem_16 [UIFont systemFontOfSize:16]
#define WLFontSystem_17 [UIFont systemFontOfSize:17]
#define WLFontSystem_18 [UIFont systemFontOfSize:18]
#define WLFontSystem_19 [UIFont systemFontOfSize:19]
#define WLFontSystem_20 [UIFont systemFontOfSize:20]
#define WLFontSystem_21 [UIFont systemFontOfSize:21]
#define WLFontSystem_22 [UIFont systemFontOfSize:22]
#define WLFontSystem_23 [UIFont systemFontOfSize:23]
#define WLFontSystem_24 [UIFont systemFontOfSize:24]
#define WLFontSystem_25 [UIFont systemFontOfSize:25]
#define WLFontSystem_26 [UIFont systemFontOfSize:26]
#define WLFontSystem_27 [UIFont systemFontOfSize:27]
#define WLFontSystem_28 [UIFont systemFontOfSize:28]
#define WLFontSystem_29 [UIFont systemFontOfSize:29]
#define WLFontSystem_30 [UIFont systemFontOfSize:30]

#pragma mark - SystemVersion
float WLDeviceSystemVersion();

#ifndef kSystemVersion
#define kSystemVersion WLDeviceSystemVersion()
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

