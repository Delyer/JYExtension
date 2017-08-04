//
//  NSArray+JYLog.m
//  JYCategory
//
//  Created by Dely on 2017/8/3.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSArray+JYLog.h"

@implementation NSArray (JYLog)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendString:@"(\n"];
    for (int i = 0; i < self.count; i++) {
        NSString *lastSymbol = (self.count == i + 1) ? @"":@",";
        id value = self[i];
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [mStr appendFormat:@"\t%@%@%@\n",tab,[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
        } else {
            [mStr appendFormat:@"\t%@%@%@\n",tab,value,lastSymbol];
        }
    }
    [mStr appendFormat:@"%@)",tab];
    return [mStr copy];

}

@end

@implementation NSDictionary (JYLog)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendString:@"{\n"];
    NSArray *allKey = self.allKeys;
    for (int i = 0; i < allKey.count; i++) {
        id value = self[allKey[i]];
        NSString *lastSymbol = (allKey.count == i + 1) ? @"":@";";
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,allKey[i],[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
        } else {
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,allKey[i],value,lastSymbol];
        }
    }
    [mStr appendFormat:@"%@}",tab];
    return [mStr copy];
}

@end
