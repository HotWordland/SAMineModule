//
//  TTSTPopupController.h
//  CloudCulturalTourism
//
//  Created by Ryzen on 2020/12/10.
//  Copyright © 2020 cqlyy. All rights reserved.
//

#import <STPopup/STPopup.h>

NS_ASSUME_NONNULL_BEGIN
/** 扩展STPopupController弹窗控制器 */
@interface TTSTPopupController : STPopupController
/**
 事件block
 */
@property (copy, nonatomic) void(^emitEvent)(id event,id param);
/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */
-(void)eventEmit:(id)event param:(id)param;

@end

NS_ASSUME_NONNULL_END
