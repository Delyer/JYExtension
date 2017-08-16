//
//  NSDictionary+JYURL.m
//  JYExtension
//
//  Created by Dely on 2017/8/4.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSDictionary+JYURL.h"

@implementation NSDictionary (JYURL)


- (NSString *)URLQueryString{
    
    NSMutableString *string = [NSMutableString string];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        NSString *encodedUrl = [self[key] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        [string appendFormat:@"%@=%@", key, encodedUrl];
    }
    return [string copy];
}

- (NSDictionary *)URLQueryDictionary{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    for (NSString *key in [self allKeys]) {
        NSString *encodedUrl = [self[key] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        if (key && encodedUrl) {
            [dict setObject:encodedUrl forKey:key];
        }
    }
    return [dict copy];
}

+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *parameters = [query componentsSeparatedByString:@"&"];
    for(NSString *parameter in parameters) {
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if(contents.count == 2) {
            NSString *key = [contents objectAtIndex:0];
            NSString *value = [contents objectAtIndex:1];
            value = [value stringByRemovingPercentEncoding];
            if (key && value) {
                [dict setObject:value forKey:key];
            }
        }
    }
    return [dict copy];
}




@end
