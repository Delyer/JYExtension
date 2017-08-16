//
//  JY3DES.h
//  JYExtension
//
//  Created by Dely on 2017/8/8.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "JYBase64.h"


@interface JY3DES : NSObject

/**
 *  3Des 加解密 对明文加密和密文解密
 *
 *  @param plainString      需要加解密的数据
 *  @param encryptOrDecrypt 加解密模式 kCCEncrypt-加密  kCCDecrypt-解密
 *  @param base64KeyString        进行base编码过后的keyString（key是24位，否则加解密有问题）
 *
 *  @return 返回加解密的结果String
 */
+ (NSString *)tripleDES:(NSString *)plainString encryptOrDecrypt:(CCOperation)encryptOrDecrypt DESBase64Key:(NSString *)base64KeyString;


@end

