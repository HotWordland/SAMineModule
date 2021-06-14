//
//  UIView+SafeAreaCompatible.m
//  RiverBank
//
//  Created by Ryzen on 2020/12/7.
//

#import "UIView+SafeAreaCompatible.h"

const char wlSafeInsetLeftKey;
const char wlSafeInsetRightKey;
const char wlSafeInsetTopKey;
const char wlSafeInsetBottomKey;

@implementation UIView (SafeAreaCompatible)
/*
-(void)setWlSafeInsetLeft:(CGFloat)wlSafeInsetLeft{
    
    objc_setAssociatedObject(self, &wlSafeInsetLeftKey, @(wlSafeInsetLeft), OBJC_ASSOCIATION_ASSIGN);
}
 */
-(CGFloat)wlSafeInsetLeft{
    if (@available(iOS 11, *)) {
        return self.safeAreaInsets.left;
    } else {
        return 0;
    }
}
-(CGFloat)wlSafeInsetRight{
    if (@available(iOS 11, *)) {
        return self.safeAreaInsets.right;
    } else {
        return 0;
    }
}
-(CGFloat)wlSafeInsetTop{
    if (@available(iOS 11, *)) {
        return self.safeAreaInsets.top;
    } else {
        return 0;
    }
}
-(CGFloat)wlSafeInsetBottom{
    if (@available(iOS 11, *)) {
        return self.safeAreaInsets.bottom;
    } else {
        return 0;
    }
}

@end
