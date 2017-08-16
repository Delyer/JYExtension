//
//  NSData+JYHandle.h
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JYHandle)

//NSData-->String
- (NSString *)getString;

//将APNS NSData类型token 格式化成字符串
- (NSString *)getAPNSToken;

@end
