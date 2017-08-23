//
//  UIImage+JYCode.h
//  JYExtension
//
//  Created by Dely on 2017/8/18.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*二维码和条形码的生成*/

#import <UIKit/UIKit.h>

@interface UIImage (JYCode)

/*生成二维码(黑白色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size;

/*生成二维码(前景色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor;

/*生成二维码(前景色、logo、logo的圆角大小)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor logoImage:(UIImage *)logo logoRadius:(CGFloat)radius;

/* 生成条形码*(iOS8.0以上适用)*/
+ (UIImage *)getBarWithString:(NSString *)string size:(CGSize)size;



@end
