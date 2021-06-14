//
//  UIImage+Handle.m
//  Travel-Tp
//
//  Created by Curse Tom on 2019/12/11.
//  Copyright © 2019 Ryzen. All rights reserved.
//

#import "UIImage+Handle.h"

@implementation UIImage (Handle)
// 生成纯色图片
+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

// 生成圆角图片
+ (UIImage *)imageWithOriginalImage:(UIImage *)originalImage{
    
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    
    [originalImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
// 生成圆角图片
+ (UIImage *)imageWithOriginalImage:(UIImage *)originalImage cornerRadius:(CGFloat)radius{
    
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    CGFloat cornerRadius = radius;
    
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    
    [originalImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// 生成纯色圆角图片
+ (UIImage *)createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize{
    
    UIImage *originalImage = [self createImageWithColor:color withSize:imageSize];
    
    return [self imageWithOriginalImage:originalImage];
}
// 生成radius值的纯色圆角图片
+ (UIImage *)createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize cornerRadius:(CGFloat)radius{
    
    UIImage *originalImage = [self createImageWithColor:color withSize:imageSize];
    
    return [self imageWithOriginalImage:originalImage cornerRadius:radius];
}


// 生成带圆环的圆角图片
+ (UIImage *)imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth{
    
    
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    
    
    [originalImage drawInRect:rect];
    
    CGPoint center = CGPointMake(originalImage.size.width * 0.5, originalImage.size.height * 0.5);
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:cornerRadius - borderWidth*0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    circlePath.lineWidth = borderWidth;
    [borderColor setStroke];
    [circlePath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
    
}
/**
 指定宽度按比例缩放
 @param sourceImage 原始图片
 @param defineWidth 指定宽度
*/
+(UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        if(widthFactor > heightFactor){

            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;

        }else if(widthFactor < heightFactor){

            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        DLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

@end
