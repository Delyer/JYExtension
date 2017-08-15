//
//  UIWindow+JYInfo.m
//  JYCategory
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIWindow+JYInfo.h"

@implementation UIWindow (JYInfo)

+ (UIViewController *)getCurrentPresentedVC{
    
    UIWindow *keywindow = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *topVC = keywindow.rootViewController;
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (UIViewController *)getCurrentVC{
    UIViewController *currentViewController = [UIWindow getCurrentPresentedVC];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController *) currentViewController topViewController]) {
        
        currentViewController = [(UINavigationController *) currentViewController topViewController];
    }
    
    return currentViewController;

}


@end
