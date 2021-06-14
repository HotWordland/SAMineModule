//
//  PrefixHeader.h
//  SA
//
//  Created by Curse Tom on 2021/5/9.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h
#import <WLKit/WLKit.h>
#import "NSArray+TTExtension.h"
#import <Toast/UIView+Toast.h>
#import "UIView+LoadFromNib.h"
#import "TTBaseController.h"
#import "BYNetWorking.h"
//#import "User.h"
#import "CVResponsiveButton.h"
#import <WYNullView/WYNullView.h>
#import "ProgressHUD.h"
#import "TTBaseView.h"
#import "UIView+SSLoading.h"
#import "UIView+SSShowNull.h"
#import "GEBasePopView.h"
#import "ScreenMeasureAdapter.h"
#import "NSLayoutConstraint+Multiplier.h"
#import "TTAnyCornerRadius.h"
//#import "CCImageView.h"
//#import "RBBaseSkeletonLoadingView.h"
#import "UIView+SafeAreaCompatible.h"
#import "TTSTPopupController.h"
#define kISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil)
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//浅灰色
#define LIGHT_GRAY RGBACOLOR(242, 242, 242, 1)
//字体淡黑色 hex
#define LIGHT_GRAY_FONTCOLOR @"606162"
//浅灰色背景
#define LIGHT_GRAY_BG RGBACOLOR(245, 245, 245, 1)
//默认占位图颜色
#define kDefaultFillPlaceHolderColorHex @"d7d7d7"
#define NAVIBARCOLOR [UIColor colorWithHexString:@"ffffff"]
#define NavGrayTextColor  [UIColor colorWithHexString:@"626364"]
#define MAINTHEMECOLOR [UIColor colorWithHexString:@"fd483b"]
#define MAINPAGETHEMECOLORHEX @"232b38"


#ifdef DEBUG
/** 带有中文的Log */
#define DLog(FORMAT, ...) fprintf(stderr,"\n%s [Line %d] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif
// random color
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
/**
 显示tips windows层
 
 @param content 内容
 @return
 */
#define TOAST_WINDOW(content) [[[UIApplication sharedApplication].delegate window] makeToast:content duration:2.0 position:CSToastPositionCenter];

/**
 动态颜色生成-适配iOS13的黑夜模式
 */
#define DYNAMIC_INTERFACECOLOR(lightColor,darkColor) ^UIColor *() {\
    if (@available(iOS 13.0, *)) {\
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {\
    if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {\
    return lightColor;\
    }else {\
    return darkColor;\
    }\
    }];\
    }\
    return lightColor;\
}()
/**
 默认弹窗询问
 */
#define ALERT_DEFAULT(messageParam,okHandlerParam,cancelHandlerParam,controllerParam) \
[GEAlertDefaultHandler showAlertWithTitle:@"提示" message:messageParam okTitle:@"确定" cancelTitle:@"取消" okHandler:okHandlerParam cancelHandler:cancelHandlerParam controller:controllerParam];\
/**
获取安全字符串
*/
#define GETSAFESTRING(string) ^NSString *() {\
if (string == nil) {\
DLog(@"string is nil");\
return @"";\
}\
if (![string isKindOfClass:[NSString class]]) {\
DLog(@"string is not string class");\
return @"";\
}\
return string;\
}()
/**
 通过电话区号标题获取电话区号代码
 */
#define TELTYPE_GETCODE(telTitle) ^NSString *() {\
GETelTypeHandle *handle = [[GETelTypeHandle alloc] init];\
return [handle convertToCode:telTitle];\
}()
/** 颜色 hex */
#define UICOLORHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UICOLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define WS(weakSelf)     __weak __typeof(&*self)weakSelf = self;

/**
 格式化字符串
 */
#define FORMAT_STRING(fmt,...)[NSString stringWithFormat:fmt,##__VA_ARGS__]



#endif /* PrefixHeader_h */
