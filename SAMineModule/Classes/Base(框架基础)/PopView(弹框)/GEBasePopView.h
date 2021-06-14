//
//  GEBasePopView.h
//  GoodEasyShop
//
//  Created by Ryzen on 2020/7/6.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//

#import "TTBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GEBasePopView : TTBaseView
/** 弹窗对象 */
@property (strong, nonatomic) KLCPopup *popUp;
/** 弹窗对象 */
@property (assign, nonatomic) KLCPopupLayout layout;
/** 显示 */
-(void)show;

@end

NS_ASSUME_NONNULL_END
