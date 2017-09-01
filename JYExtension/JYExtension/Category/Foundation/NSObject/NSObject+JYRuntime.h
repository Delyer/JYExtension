//
//  NSObject+JYRuntime.h
//  JYExtension
//
//  Created by Dely on 2017/9/1.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JYRuntime)

/* 获取对象的成员变量*/
- (NSArray *)getAllIvars;

/* 获取对象的所有属性*/
- (NSArray *)getAllProperties;

/* 获取对象的所有方法*/
- (NSArray *)getAllMethods;

@end
