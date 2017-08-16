//
//  UIColor+JYBlock.h
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *UIAlertView的block方法
 */

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (JYBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewCallBackBlock callBackBlock;

+ (void)alertWithCallBackBlock:(UIAlertViewCallBackBlock)block title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
