//
//  NSObject+JYRuntime.m
//  JYExtension
//
//  Created by Dely on 2017/9/1.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSObject+JYRuntime.h"
#import <objc/message.h>

@implementation NSObject (JYRuntime)

/* 获取对象的成员变量*/
- (NSArray *)getAllIvars{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        [array addObject:[NSString stringWithUTF8String:ivarName]];
    }
    free(ivars);
    return [array copy];
}

/* 获取对象的所有属性*/
- (NSArray *)getAllProperties{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [array addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(properties);
    return [array copy];
}

/* 获取对象的所有方法*/
- (NSArray *)getAllMethods{
    
    unsigned int count =0;
    Method* methodList = class_copyMethodList([self class],&count);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(int i = 0; i<count; i++){
        Method method = methodList[i];
        SEL sel = method_getName(method);
        const char *name = sel_getName(sel);
        [array addObject:[NSString stringWithUTF8String:name]];
    }
    free(methodList);
    
    return [array copy];
}

@end
