//
//  NSString+JYJudge.h
//  JYCategory
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *处理字符串的判断
 */

#import <Foundation/Foundation.h>

@interface NSString (JYJudge)

//字符串是否为空的 空：YES 否：NO
+ (BOOL)isEmptyWithString:(NSString *)string;

//是否包含字符串
- (BOOL)containString:(NSString *)string;
//是否包含中文字符
- (BOOL)containsChineseCharacter;

// 判断字符串是否是条码
- (BOOL)isBarcode;

//判断是否是url
- (BOOL)isUrl;

//判断是否是email
- (BOOL)isEmail;

//判断是否是电话号码
- (BOOL)isTelephone;

// 判断是否是身份证
- (BOOL)isIdCard;

//根据身份证号获取生日:YYYY-MM-dd字符串
- (NSString *)birthdayWithIdCard;

//验证密码格式，数字，字母，符号组合验证
- (BOOL)isPassWord;



@end
