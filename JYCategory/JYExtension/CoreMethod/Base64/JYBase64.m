//
//  JYBase64.m
//  JYCategory
//
//  Created by Dely on 2017/8/8.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JYBase64.h"
#import <Availability.h>

@implementation NSData (JYBase64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string{
    return [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)base64Encode{
    return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end


@implementation NSString (Base64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string{
    
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data){
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)base64Encode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64Encode];
}

- (NSString *)base64Decode{
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData{
    return [NSData dataWithBase64EncodedString:self];
}

@end
