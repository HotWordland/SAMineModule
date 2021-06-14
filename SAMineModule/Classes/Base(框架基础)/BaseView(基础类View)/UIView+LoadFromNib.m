//
//  UIView+LoadFromNib.m
//  Travel-Tp
//
//  Created by Ryzen on 2019/10/30.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "UIView+LoadFromNib.h"
#import <objc/runtime.h>

@implementation UIView (LoadFromNib)

+ (instancetype)fm_viewFromXib{
    UIView *view = nil;
    NSArray *views = nil;
    views = [self fm_loadFromNib];
    if (views == nil) {
        return [[self alloc] init];
    }
    view = views.lastObject;
    if (view == nil) {
        return [[self alloc] init];
    }
    object_setClass(view, self);
    return view;
}

+ (NSArray *)fm_loadFromNib{
    if ([self fm_loadNibFromName:NSStringFromClass(self)]) {
        return [self fm_loadNibFromName:NSStringFromClass(self)];
    } else {
        NSArray *arrM = nil;
        NSString *name = NSStringFromClass([super class]);
        while (![name isEqualToString:NSStringFromClass([UIResponder class])]) {
            //            name = [self fm_xibFileName];
            if ([self fm_loadNibFromName:name]) {
                arrM = [self fm_loadNibFromName:name];
                break;
            } else {
                Class superClass = NSClassFromString(name);
                superClass = class_getSuperclass(superClass);
                name = NSStringFromClass(superClass);
            }
        }
        return arrM;
    }
}

+ (NSArray *)fm_loadNibFromName:(NSString *)name{
    if ([self fm_isExsitNibWithName:name]) {
        return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
    }
    return nil;
}

+ (BOOL)fm_isExsitNibWithName:(NSString *)name{
    return [[NSBundle mainBundle] pathForResource:name ofType:@"nib"] != nil;
}

+ (NSString *)fm_xibFileName{
    return NSStringFromClass(self);
    
}

/**
 加载xib文件 针对xib继承的情况
 */
-(void)fm_instanceLoadXib
{
    if ([[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"nib"] != nil) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        return;
    } else {
        NSString *name = NSStringFromClass([super class]);
        while (![name isEqualToString:NSStringFromClass([UIResponder class])]) {
            //            name = [self fm_xibFileName];
            if ([[NSBundle mainBundle] pathForResource:name ofType:@"nib"] != nil) {
                [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
                return;
            }else{
                Class superClass = NSClassFromString(name);
                superClass = class_getSuperclass(superClass);
                name = NSStringFromClass(superClass);
            }
        }
        return;
    }
    
}
@end

