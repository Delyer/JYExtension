//
//  NSString+JYURLEncode.m
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSString+JYURLEncode.h"

@implementation NSString (JYURLEncode)

- (NSString *)urlEncode{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

- (NSString *)urlDecode{
    return [self stringByRemovingPercentEncoding];
}

@end
