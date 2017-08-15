//
//  JY3DES.m
//  JYCategory
//
//  Created by Dely on 2017/8/8.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JY3DES.h"

@implementation JY3DES

+ (NSString *)tripleDES:(NSString *)plainString encryptOrDecrypt:(CCOperation)encryptOrDecrypt DESBase64Key:(NSString *)base64KeyString {
    
    //对base64编码过后的BasekeyString进行解码成真正的keyString
    NSData *keyData = [base64KeyString base64DecodedData];
    const void *vkey = (const void *) [keyData bytes];
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt) {
        //解密
        NSData *EncryptData = [plainString base64DecodedData];
        plainTextBufferSize = [EncryptData length];
        vplainText = (const void *)[EncryptData bytes];
        
    } else {
        //加密
        NSData *data = [plainString dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *) bufferPtr, 0x0, bufferPtrSize);
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *) bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *resultString;
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger) movedBytes];
    
    if (encryptOrDecrypt == kCCDecrypt) {
        //解密
        resultString = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
    } else {
        //加密
        resultString = [myData base64Encode];
    }
    if (bufferPtr) {
        free(bufferPtr);
    }
    
    return resultString;
    
}


@end
