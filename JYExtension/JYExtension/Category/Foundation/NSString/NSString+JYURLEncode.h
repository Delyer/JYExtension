//
//  NSString+JYURLEncode.h
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *处理URL编码
 */

#import <Foundation/Foundation.h>

@interface NSString (JYURLEncode)

//url编码
- (NSString *)urlEncode;
////url解码
- (NSString *)urlDecode;

@end
