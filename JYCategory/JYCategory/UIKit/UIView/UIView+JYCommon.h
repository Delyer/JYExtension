//
//  UIView+JYCommon.h
//  JYCategory
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYCommon)

//获取view所在的ViewController
- (UIViewController *)viewController;

//获取view所在的ViewController的name
- (NSString *)viewControllerName;

//通过名称获取nib
+ (UINib *)nibWithName:(NSString *)name;

//通过NIb名称获取内部View视图集合
+ (NSArray *)viewsWithNibName:(NSString *)name;

//设置圆角 (圆角大小 圆角宽度 圆角颜色)
- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;



@end
