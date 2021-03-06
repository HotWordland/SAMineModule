//
//  TTAnyCornerRadius.h
//  CloudCulturalTourism
//
//  Created by Curse Tom on 2020/10/24.
//  Copyright © 2020 cqlyy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
     CGFloat topLeft;
     CGFloat topRight;
     CGFloat bottomLeft;
     CGFloat bottomRight;
} CornerRadii;

/** 任意圆角 */
@interface TTAnyCornerRadius : NSObject

CornerRadii CornerRadiiMake(CGFloat topLeft,CGFloat topRight,CGFloat bottomLeft,CGFloat bottomRight);
//切圆角函数
CGPathRef CYPathCreateWithRoundedRect(CGRect bounds,
                                      CornerRadii cornerRadii);
/**
 画渐变线
 @param context 上下文
 @param components 渐变颜色数组
 @param componentCount 数组大小
 @param width 线宽
 @param startPoint 起始位置
 @param endPoint 结束位置
 */
void drawLinearGradient(CGContextRef cg_nullable context,const CGFloat * cg_nullable components,int componentCount,CGFloat width,CGPoint startPoint,CGPoint endPoint,CGGradientDrawingOptions options);
/**
 画线
 @param context 上下文
 @param color 线颜色
 @param width 线宽
 @param startPoint 起始位置
 @param endPoint 结束位置
 */
void drawLine(CGContextRef cg_nullable context,CGColorRef color,CGFloat width,CGPoint startPoint,CGPoint endPoint);

/**
 画弧线
 @param context 上下文
 @param color 线颜色
 @param width 线宽
 @param centerPoint 圆心位置
 @param radius 半径
 @param startAngle 起始角度
 @param endAngle 结束角度
 @param clockwise 是否闭合
 */
void drawLineArc(CGContextRef cg_nullable context,CGColorRef color,CGFloat width,CGPoint centerPoint,CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise);
/**
 根据CornerRadii切圆角
 @param view 视图
 @param cm CornerRadii信息
 */
+(void)cornerRadiusWithView:(UIView *)view radiiMake:(CornerRadii)cm;
/**
 根据CornerRadii切圆角和边框线
 @param view 视图
 @param cm CornerRadii信息
 */
+(void)cornerRadiusBorderWithView:(UIView *)view lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)color radiiMake:(CornerRadii)cm;

@end

@interface CALayer (TTAnyCornerRadiusBorderLayer)
/** 记录border layer */
@property (nonatomic, strong, readwrite) CALayer *ttAnyBorderLayer;

@end

NS_ASSUME_NONNULL_END
