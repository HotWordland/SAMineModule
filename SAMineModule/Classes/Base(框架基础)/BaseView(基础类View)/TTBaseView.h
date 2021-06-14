//
//  TTBaseView.h
//  Travel-Tp
//
//  Created by Ryzen on 2019/10/30.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseView : UIView

/**
 视图view xib复用的情况
 */
@property (weak, nonatomic) IBOutlet UIView *view;
///layout 信息
@property (nonatomic,strong)NSDictionary *layinfo;
/**
 设置ui
 */
- (void)setUpUi;
/**
 从frame加在不读取文件

 @param frame 尺寸
 @return instance
 */
-(instancetype)initWithFrameNotSetUpUi:(CGRect)frame;
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
///获取layout item的值
-(CGFloat)getLayoutinfoItem:(NSString *)attribute;
+(CGFloat)get_width;
+(CGFloat)get_height;
/**
 加载圆角样式
*/
+(void)loadCornerRadiusStyleWithView:(UIView *)view roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
/**
 配置输入框样式和placeHolder
*/
+(void)configInputFieldStyleWithPlaceHolder:(NSString *)placeHolder textField:(UITextField *)field placeHolderColor:(UIColor *)placeHolderColor;
/**
 配置项目中一般输入框的样式
*/
+(void)configCommonInputTextfieldStyle:(UITextField *)textField;
/**
 从xib生成实例
*/
+(id)generateFromInstanceLoadXib;

@end

NS_ASSUME_NONNULL_END
