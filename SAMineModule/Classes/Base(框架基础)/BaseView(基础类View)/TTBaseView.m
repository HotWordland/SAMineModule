//
//  TTBaseView.m
//  Travel-Tp
//
//  Created by Ryzen on 2019/10/30.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "TTBaseView.h"

@implementation TTBaseView

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUi];
    }
    return self;
}
-(instancetype)initWithFrameNotSetUpUi:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
/**
 从文件中加在view
 
 @param aDecoder NSCoder对象
 @return instance
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpUi];
    }
    return self;
    
}
/**
 设置ui
 */
- (void)setUpUi{
    [self fm_instanceLoadXib];
    if (self.view) {
        PREPCONSTRAINTS(self.view);
        [self addSubview:self.view];
        ALIGN_TOP(self.view, 0);
        ALIGN_BOTTOM(self.view, 0);
        ALIGN_LEFT(self.view, 0);
        ALIGN_RIGHT(self.view, 0);
    }
}
+(id)generateFromInstanceLoadXib
{
    return [[self.class alloc] initWithFrame:CGRectZero];
}
/** 获取当前布局状态高度 */
-(CGFloat)getCurrentLayoutHeight
{
    [self layoutIfNeeded];
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

-(CGFloat)getLayoutinfoItem:(NSString *)attribute{
    if (!self.layinfo) {
        NSAssert(self.layinfo, @"layinfo 不能为空");
        return 0.f;
    }
    if (!self.layinfo[attribute]) {
        NSString *as_string = [NSString stringWithFormat:@"此%@ - attribute 未定义",attribute];
        NSAssert(self.layinfo[attribute], as_string);
        DLog(@"%@",as_string);
        return 0.f;
    }
    NSNumber *num_attribute = self.layinfo[attribute];
    CGFloat value = [num_attribute floatValue];
    return value;
}
/**
 加载圆角样式
 */
+(void)loadCornerRadiusStyleWithView:(UIView *)view roundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    //只让上方左和右有圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
/**
 配置输入框样式和placeHolder
 */
+(void)configInputFieldStyleWithPlaceHolder:(NSString *)placeHolder textField:(UITextField *)field placeHolderColor:(UIColor *)placeHolderColor
{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeHolder attributes:
                                      @{NSForegroundColorAttributeName:placeHolderColor,
                                        NSFontAttributeName:field.font
                                      }];
    field.attributedPlaceholder = attrString;
}

/**
 事件触发
 
 @param event 事件名
 @param param 参数
 */
-(void)eventEmit:(id)event param:(id)param
{
    !self.emitEvent ?: self.emitEvent(event, param);
}
+(CGFloat)get_height{
    return 0;
}
+(CGFloat)get_width{
    return 0;
}

#pragma mark - Bussiness function

/**
 配置项目中一般输入框的样式
 */
+(void)configCommonInputTextfieldStyle:(UITextField *)textField
{
    [self.class configInputFieldStyleWithPlaceHolder:textField.placeholder textField:textField placeHolderColor:[UIColor colorWithHexString:@"#CCCCCC"]];
}

@end
