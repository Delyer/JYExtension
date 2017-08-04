//
//  JYSwizzing.m
//  RunTime
//
//  Created by Dely on 2017/5/16.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JYSwizzing.h"
#import <objc/message.h>

@implementation JYSwizzing

//对象方法方法交换
+ (void)JYInstanceSwizzleSelector:(Class)className originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    //交换方法应该被保证，在程序中只会执行一次(黑魔法)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //两个方法的method
        Method originMethod = class_getInstanceMethod(className, originalSelector);
        Method exchangeMethod = class_getInstanceMethod(className, swizzledSelector);
        
        //首先动态添加方法，实现被替换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(className, originalSelector, method_getImplementation(exchangeMethod), method_getTypeEncoding(exchangeMethod));
        
        if (isAdd) {
            //如果成功，说明类中不存在替换的方法的实现，如果调用直接就会crash，
            //不存在，就把我们被替换的方法的实现来替换到这个不存在的原方法的实现
            class_replaceMethod(className, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(exchangeMethod));
        }else{
            //不成功，说明替换方法是实现的，交换两个方法的实现
            method_exchangeImplementations(originMethod, exchangeMethod);
        }
    });
}

//类方法方法交换
+ (void)JYClassSwizzleSelector:(Class)className originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //两个方法的method
        Method originMethod = class_getClassMethod(className, originalSelector);
        Method exchangeMethod = class_getClassMethod(className, swizzledSelector);
        method_exchangeImplementations(originMethod, exchangeMethod);
    });

}


@end
