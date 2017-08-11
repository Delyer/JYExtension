//
//  UIImage+JYHandle.m
//  JYCategory
//
//  Created by Dely on 2017/8/11.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIImage+JYHandle.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


@implementation UIImage (JYHandle)

/*************************************************************
 基本知识：
 UIGraphicsBeginImageContext
 创建一个基于位图的上下文（context）,并将其设置为当前上下文(context)，
 参数size为新创建的位图上下文的大小。它同时是由UIGraphicsGetImageFromCurrentImageContext函数返回的图形大小。
 该函数的功能同UIGraphicsBeginImageContextWithOptions的功能相同，相当与UIGraphicsBeginImageContextWithOptions的opaque参数为NO,scale因子为1.0。
 即 UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeWith, sizeHeight), NO, 1.0);
 = UIGraphicsBeginImageContext(CGSizeMake(sizeWith, sizeHeight));
 
 size——同UIGraphicsBeginImageContext
 opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
 scale—–缩放因子
 *************************************************************/

//加水印
+ (instancetype)waterMarkWithImage:(UIImage *)backgroundImage markImage:(UIImage *)markImage location:(CGRect)markLocation{
    
    CGFloat sizeWith = backgroundImage.size.width;
    CGFloat sizeHeight = backgroundImage.size.height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeWith, sizeHeight), NO, 0.0);
    [backgroundImage drawInRect:CGRectMake(0, 0, sizeWith, sizeHeight)];
    
    [markImage drawInRect:markLocation];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//等比缩放
+ (instancetype)scaleImage:(UIImage *)scaleImage toScale:(float)scaleSize{
    
    CGFloat sizeWith = scaleImage.size.width * scaleSize;
    CGFloat sizeHeight = scaleImage.size.height * scaleSize;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeWith, sizeHeight), NO, 0.0);
    
    [scaleImage drawInRect:CGRectMake(0, 0, sizeWith, sizeHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//自定义大小缩放
+ (instancetype)customSizeImage:(UIImage *)image customSize:(CGSize)customSize{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(customSize.width, customSize.height), NO, 0.0);
    
    [image drawInRect:CGRectMake(0, 0, customSize.width, customSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 自定义剪切后的图片
+ (instancetype)customCutImage:(UIImage *)image AtRect:(CGRect)rect{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage* subImage = [UIImage imageWithCGImage: subImageRef];
    CGImageRelease(subImageRef);
    
    return subImage;
}

//根据颜色和大小获取一张图片
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//对图片自定义角度旋转（以中心点为旋转点，以°为旋转单位，如90°）
+ (instancetype)customImageRotate:(UIImage *)image rotatedDegrees:(CGFloat)degrees{
    
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), image.CGImage);
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

//对图片自定义角度旋转（以中心点为旋转点,以M_PI为旋转单位，如M_PI/4.0）
+ (instancetype)customImageRotate:(UIImage *)image rotatedRadians:(CGFloat)radians{
    return [UIImage customImageRotate:image rotatedDegrees:RadiansToDegrees(radians)];
}

+ (instancetype)cutRoundimage:(UIImage *)image borderImage:(UIImage *)borderImage border:(int)border{
    
    CGSize size = CGSizeMake(image.size.width + border, image.size.height + border);
    
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    //绘制边框的圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    //剪切可视范围
    CGContextClip(context);
    
    //绘制边框图片
    [borderImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //设置头像frame
    CGFloat iconX = border / 2;
    CGFloat iconY = border / 2;
    CGFloat iconW = image.size.width;
    CGFloat iconH = image.size.height;
    
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
    
    //剪切可视范围
    CGContextClip(context);
    
    //绘制头像
    [image drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];
    
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return iconImage;
}



@end
