//
//  UIView+JYResponder.m
//  JYExtension
//
//  Created by Dely on 2017/11/17.
//  Copyright © 2017年 Dely. All rights reserved.
//


#import "UIView+JYResponder.h"
#import <objc/runtime.h>

@implementation UIView (JYResponder)

//统一处理点击空白收键盘
- (void)enableResignFirstResponder{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!tapGestureRecognizer) {
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
        objc_setAssociatedObject(self, _cmd, tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)handleTapGesture{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
