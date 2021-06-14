//
//  UIImage+Handle.h
//  Travel-Tp
//
//  Created by Curse Tom on 2019/12/11.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Handle)
// 生成纯色圆角图片
+ (UIImage *)createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;
// 生成radius值的纯色圆角图片
+ (UIImage *)createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize cornerRadius:(CGFloat)radius;
/**
 指定宽度按比例缩放
 @param sourceImage 原始图片
 @param defineWidth 指定宽度
*/
+(UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end

NS_ASSUME_NONNULL_END
