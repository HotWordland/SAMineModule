//
//  GEBasePopView.m
//  GoodEasyShop
//
//  Created by Ryzen on 2020/7/6.
//  Copyright © 2020 GoodEasyShop. All rights reserved.
//

#import "GEBasePopView.h"

@implementation GEBasePopView

-(void)show
{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutBottom);
    KLCPopup* popup = [KLCPopup popupWithContentView:self
                                            showType:(KLCPopupShowType)self.showType
                                         dismissType:(KLCPopupDismissType)self.dismissType
                                            maskType:(KLCPopupMaskType)self.maskType
                            dismissOnBackgroundTouch:true
                               dismissOnContentTouch:NO];
    [popup showWithLayout:layout];
    self.layout = layout;
    self.popUp = popup;
}
-(KLCPopupShowType)showType{
    return KLCPopupShowTypeBounceIn;
}
-(KLCPopupDismissType)dismissType{
    return KLCPopupDismissTypeShrinkOut;
}
-(KLCPopupMaskType)maskType{
    return KLCPopupMaskTypeDimmed;
}

@end
