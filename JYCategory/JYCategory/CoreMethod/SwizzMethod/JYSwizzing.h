//
//  JYSwizzing.h
//  RunTime
//
//  Created by Dely on 2017/5/16.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSwizzing : NSObject

//对象方法方法交换
+ (void)JYInstanceSwizzleSelector:(Class)className originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

//类方法方法交换
+ (void)JYClassSwizzleSelector:(Class)className originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
