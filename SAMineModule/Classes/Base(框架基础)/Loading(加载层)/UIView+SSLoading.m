//
//  UIView+SSLoading.m
//  StarScreenPlay
//
//  Created by 巫龙 on 2018/4/9.
//  Copyright © 2018年 巫龙. All rights reserved.
//

#import "UIView+SSLoading.h"
#import <WYNullView/WYNullView.h>
#import "CVResponsiveButton.h"
@implementation UIView (SSLoading)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //case1: 替换实例方法
        Class selfClass = [self class];
        //case2: 替换类方法
        //        Class selfClass = object_getClass([self class]);
        
        //源方法的SEL和Method
        SEL oriSEL = @selector(layoutSubviews);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        //交换方法的SEL和Method
        SEL cusSEL = @selector(hook_layoutSubviews);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        //先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            //添加成功：将源方法的实现替换到交换方法的实现
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

/**
 hook layoutSubviews的方法 用来准确化loadingView尺寸
 */
-(void)hook_layoutSubviews{
    //这里调用的其实是原始的 因为已经交换了
    [self hook_layoutSubviews];
    if (self.wy_loadingView) {
        self.wy_loadingView.size = self.size;
        self.wy_loadingView.top = 0;
        self.wy_loadingView.left = 0;
        self.wy_loadingMaskView.size = self.size;
        self.wy_loadingMaskView.top = 0;
        self.wy_loadingMaskView.left = 0;
    }
    if (self.wy_nullView) {
        self.wy_nullView.size = self.size;
        self.wy_nullView.center = CGPointMake(self.width/2, self.height/2);
    }
    //tableview上loadingView的尺寸需要这样判断
//    if ([self isKindOfClass:[TTBaseLoadingView class]]) {
    if ([self isKindOfClass:[LoadingView class]]) {
        if(self.superview.wy_loadingView == self){
            if ([self.superview isKindOfClass:[UITableView class]] || [self.superview isKindOfClass:[CVResponsiveButton class]]) {
                self.size = self.superview.size;
                self.top = 0;
                self.left = 0;
                self.superview.wy_loadingMaskView.size = self.superview.size;
                self.superview.wy_loadingMaskView.top = 0;
                self.superview.wy_loadingMaskView.left = 0;
                }
        }
    }
}
-(void)ssStartLoadingWithDefaultBgColor{
//    [self ssStartLoadingWithBgColor:[UIColor colorWithHexString:@"F1F5F6"]];
    [self ssStartLoadingWithBgColor:[UIColor whiteColor]];

}
-(void)ssStartLoadingWithBgColor:(UIColor *)color{
    [BaseHandle configLoadingView:self bounds:self.bounds];
    self.wy_loadingView.backgroundColor = color;
    [self wy_startLoding];
}
-(void)ssStartLoading
{
    [BaseHandle configLoadingView:self bounds:self.bounds];
    self.wy_loadingView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self wy_startLoding];
}
-(void)ssStopLoading
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self wy_stopLoding];
    });
}
@end
