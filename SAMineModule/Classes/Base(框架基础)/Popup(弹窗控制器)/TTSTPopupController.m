//
//  TTSTPopupController.m
//  CloudCulturalTourism
//
//  Created by Ryzen on 2020/12/10.
//  Copyright © 2020 cqlyy. All rights reserved.
//

#import "TTSTPopupController.h"

@implementation TTSTPopupController
/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */
-(void)eventEmit:(id)event param:(id)param
{
    !self.emitEvent ?: self.emitEvent(event, param);
}

@end
