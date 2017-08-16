//
//  NSString+JYJudge.m
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSString+JYJudge.h"

@implementation NSString (JYJudge)

+ (BOOL)isEmptyWithString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (BOOL)containString:(NSString *)string{
    if (![NSString isEmptyWithString:self]) {
        return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
    }
    return NO;
}

- (BOOL)containsChineseCharacter {
    for (int i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            return YES;
        }
    }
    return NO;
}


- (BOOL)isBarcode {
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numPre evaluateWithObject:self];
}

- (BOOL)isUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


- (BOOL)isTelephone {
    NSString * MOBILE = @"^1(3[0-9]|47|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";;
    NSString * CU = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    NSString * CT = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}

- (BOOL)isPassWord {
    NSString *phoneRegex = @"^[A-Za-z0-9!$#%@^&*_-~)(/.,\';+:]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isIdCard {
    //身份证为15位或者18位，15位的全为数字，18位的前17位为数字，最后一位为数字或者大写字母”X“
    NSString *idCardRegex = @"(^\\d{15}$)|(^\\d{17}([0-9]|X)$)";
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCardRegex];
    return [idCardTest evaluateWithObject:self];
}

- (NSString *)birthdayWithIdCard {
    if ([self isIdCard]) {
        NSMutableString *result = [NSMutableString stringWithCapacity:0];
        NSString *year = nil;
        NSString *month = nil;
        NSString *day = nil;
        
        year = [self substringWithRange:NSMakeRange(6, 4)];
        month = [self substringWithRange:NSMakeRange(10, 2)];
        day = [self substringWithRange:NSMakeRange(12, 2)];
        
        [result appendString:year];
        [result appendString:@"-"];
        [result appendString:month];
        [result appendString:@"-"];
        [result appendString:day];
        return result;
    }
    return nil;
}


@end
