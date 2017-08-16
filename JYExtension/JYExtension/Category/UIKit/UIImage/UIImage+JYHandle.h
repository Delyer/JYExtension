//
//  UIImage+JYHandle.h
//  JYExtension
//
//  Created by Dely on 2017/8/11.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JYHandle)

/**
 *  对图片进行水印处理
 *
 *  @param backgroundImage 背景图片
 *  @param markImage       水印图片
 *  @param markLocation    水印位置
 *
 *  @return 加水印后的图片
 */
+ (instancetype)waterMarkWithImage:(UIImage *)backgroundImage markImage:(UIImage *)markImage location:(CGRect)markLocation;

/**
 *  对图片进行等比缩放
 *
 *  @param scaleImage 缩放的图片
 *  @param scaleSize  缩放比例
 *
 *  @return 缩放后的图片
 */
+ (instancetype)scaleImage:(UIImage *)scaleImage toScale:(float)scaleSize;

/**
 *  对图片进行自定义大小缩放
 *
 *  @param image      缩放的图片
 *  @param customSize 缩放的大小
 *
 *  @return 缩放后的图片
 */
+ (instancetype)customSizeImage:(UIImage *)image customSize:(CGSize)customSize;

/**
 *  对图片进行自定义剪切
 *
 *  @param image 需要剪切的图片
 *  @param rect 需要剪切的图片位置大小
 *
 *  @return 剪切后的图片
 */
+ (instancetype)customCutImage:(UIImage *)image AtRect:(CGRect)rect;

/**
 *  根据颜色和大小获取一张图片
 *
 *  @param color   颜色
 *  @param size    大小
 *
 *  @return 图片
 */
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 *  对图片自定义角度旋转（以中心点为旋转点，以°为旋转单位，如90°）
 *
 *  @param image   需要旋转的图片
 *  @param degrees 旋转的角度
 *
 *  @return 旋转后的图片
 */
+ (instancetype)customImageRotate:(UIImage *)image rotatedDegrees:(CGFloat)degrees;

/**
 *  对图片自定义角度旋转（以中心点为旋转点,以M_PI为旋转单位，如M_PI/4.0）
 *
 *  @param image   需要旋转的图片
 *  @param radians 旋转的角度
 *
 *  @return 旋转后的图片
 */
+ (instancetype)customImageRotate:(UIImage *)image rotatedRadians:(CGFloat)radians;

+ (instancetype)cutRoundimage:(UIImage *)image borderImage:(UIImage *)borderImage border:(int)border;




@end
