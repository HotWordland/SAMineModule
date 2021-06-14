//
//  TTBaseTableViewCell.h
//  Travel-Tp
//
//  Created by Ryzen on 2019/11/4.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseTableViewCell : UITableViewCell
/**
 视图view xib复用的情况
 */
@property (weak, nonatomic) IBOutlet UIView *view;
/**
 事件block
 */
@property (copy, nonatomic) void(^emitEvent)(id event,id param);
/**
 optional
 传递的数据
 */
@property (strong, nonatomic) id passInfo;
/**
 当前下标
 */
@property (weak, nonatomic) NSIndexPath *curPath;
/**
 获取该类型cell的高度

 @return 高度
 */
+(CGFloat)getHeight;

/**
 xib工厂方法

 @return 实例
 */
+(id)generateView;

/**
 xib工厂方法

 @param xibName xib文件名
 @return 实例
 */
+(id)generateViewWithXibName:(NSString *)xibName;
/**
 设置ui
 */
- (void)setUpUi;

/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */

-(void)eventEmit:(id)event param:(id)param;

/** 获取当前布局状态高度 */
-(CGFloat)getCurrentLayoutHeight;

@end

NS_ASSUME_NONNULL_END
