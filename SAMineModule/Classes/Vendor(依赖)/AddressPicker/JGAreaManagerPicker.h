//
//  JGAreaManagerPicker.h
//  JGAreaPicker
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddressReturnBackInfo)(NSString *detailAddress,NSString *codes);

@interface JGAreaManagerPicker : UIView

// 解析出来的最外层数组
@property (nonatomic, strong) NSArray *addressArr;

@property (nonatomic, copy) AddressReturnBackInfo backInfo;

-(void)showActionSheetView;


@end

NS_ASSUME_NONNULL_END
