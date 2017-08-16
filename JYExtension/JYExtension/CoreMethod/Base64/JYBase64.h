//
//  JYBase64.h
//  JYExtension
//
//  Created by Dely on 2017/8/8.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *Base64是一种数据编码方式，目的是让数据符合传输协议的要求.并不是加密方式! 切记
 */

#import <Foundation/Foundation.h>

@interface  NSData (JYBase64)

//base64编码后的字符串-->原始NSData(二进制)
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

//原始NSData(二进制)-->base64编码后的字符串
- (NSString *)base64Encode;

@end

@interface  NSString (JYBase64)

//base64编码后的字符串-->正常的字符串
+ (NSString *)stringWithBase64EncodedString:(NSString *)string;

//base64编码
- (NSString *)base64Encode;

//base64解码
- (NSString *)base64Decode;

//base64编码后的字符串-->原始NSData(二进制)
- (NSData *)base64DecodedData;

@end
