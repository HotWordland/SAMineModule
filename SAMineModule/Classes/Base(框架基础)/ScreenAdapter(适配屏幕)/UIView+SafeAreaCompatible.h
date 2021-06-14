//
//  UIView+SafeAreaCompatible.h
//  RiverBank
//
//  Created by Ryzen on 2020/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SafeAreaCompatible)
/** left */
@property (nonatomic, assign, readonly) CGFloat wlSafeInsetLeft;
/** right */
@property (nonatomic, assign, readonly) CGFloat wlSafeInsetRight;
/** top */
@property (nonatomic, assign, readonly) CGFloat wlSafeInsetTop;
/** bottom */
@property (nonatomic, assign, readonly) CGFloat wlSafeInsetBottom;

@end

NS_ASSUME_NONNULL_END
