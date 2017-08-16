//
//  UIWindow+JYInfo.h
//  JYExtension
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (JYInfo)

//获取当前屏幕中present出来的viewcontroller。
+ (UIViewController *)getCurrentPresentedVC;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

@end
