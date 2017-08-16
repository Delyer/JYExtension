//
//  NSString+JYTransform.h
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *处理数据的加密以及简单数据转换
 */

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "JYBase64.h"

@interface NSString (JYTransform)

//NSString转为NSData
- (NSData *)getData;

//NSString转为Char
- (const char *)getChar;

//MD5加密(常规32位)
- (NSString *)md5;

//sha1加密
- (NSString *)sha1;
//sha256加密
- (NSString *)sha256;
//sha384加密
- (NSString *)sha384;
//sha512加密
- (NSString *)sha512;


/**
 *  3Des 加解密 对明文加密和密文解密
 *  @param encryptOrDecrypt 加解密模式 kCCEncrypt-加密  kCCDecrypt-解密
 *  @param base64KeyString        进行base编码过后的keyString（key是24位，否则加解密有问题）
 *
 *  @return 返回加解密的结果String
 */
- (NSString *)tripleDESWithEncryptOrDecrypt:(CCOperation)encryptOrDecrypt DESBase64Key:(NSString *)base64KeyString;



@end
