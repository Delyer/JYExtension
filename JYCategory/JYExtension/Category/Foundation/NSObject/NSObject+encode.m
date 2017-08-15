//
//  NSObject+encode.m
//  RunTime
//
//  Created by Dely on 2017/5/16.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSObject+encode.h"
#import <objc/message.h>

@implementation NSObject (encode)

//归档
- (void)encodeObjectWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);

    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //kvc取出属性值，归档
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
}

//解档
- (void)decodeObjectCoder:(NSCoder *)aDecoder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //kvc取出属性值，解档
        id value = [aDecoder decodeObjectForKey:key];
        //设置到成员变量身上
        [self setValue:value forKey:key];
    }
    free(ivars);
}

@end
