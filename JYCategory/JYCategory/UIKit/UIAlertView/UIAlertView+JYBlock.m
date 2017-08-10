//
//  UIAlertView+JYBlock.m
//  JYCategory
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIAlertView+JYBlock.h"
#import <objc/runtime.h>

/*********************************************************************************************
 普及知识点：
 1.NS_REQUIRES_NIL_TERMINATION 告知编译器 需要一个结尾的参数,告知编译器参数的列表已经到最后一个不要再继续执行下去了。
   如果声明了在调用方法时如果没有更多的参数一定加上nil，否则会一直循环取出参数造成崩溃.
 2.<stdarg.h>类中
 //VA_LIST 是在C语言中解决变参问题的一组宏
 //VA_START宏，获取可变参数列表的第一个参数的地址,在这里是获取otherButtonTitles的内存地址,这时args的指针 指向otherButtonTitles
 //VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
 //首先 args的内存地址指向的otherButtonTitles将对应储存的值取出,如果不为nil则判断为真,将取出的值房在数组中,
  并且将指针指向下一个参数,这样每次循环args所代表的指针偏移量就不断下移直到取出nil
 // 清空列表va_end(argList)和va_start成对出现

*********************************************************************************************/

@implementation UIAlertView (JYBlock)

+ (void)alertWithCallBackBlock:(UIAlertViewCallBackBlock)block title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: otherButtonTitles, nil];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [alert addButtonWithTitle:other];
        }
        va_end(args);
    }
    alert.delegate = alert;
    [alert show];
    alert.callBackBlock = block;
}


//setter方法
- (void)setCallBackBlock:(UIAlertViewCallBackBlock)callBackBlock{
    objc_setAssociatedObject(self, _cmd, callBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//get方法
- (UIAlertViewCallBackBlock)callBackBlock{
    return objc_getAssociatedObject(self, @selector(setCallBackBlock:));
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.callBackBlock) {
        self.callBackBlock(buttonIndex);
    }
}

@end
