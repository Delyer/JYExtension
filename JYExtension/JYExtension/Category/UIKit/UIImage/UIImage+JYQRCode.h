//
//  UIImage+JYQRCode.h
//  JYExtension
//
//  Created by Dely on 2017/8/18.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*二维码的生成*/

#import <UIKit/UIKit.h>

@interface UIImage (JYQRCode)

/*生成二维码(黑白色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size;

/*生成二维码(前景色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor;

/*生成二维码(前景色、logo、logo的圆角大小)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor logoImage:(UIImage *)logo logoRadius:(CGFloat)radius;


@end
