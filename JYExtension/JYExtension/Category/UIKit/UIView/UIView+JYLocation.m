//
//  UIView+JYLocation.m
//  JYExtension
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIView+JYLocation.h"

@implementation UIView (JYLocation)

- (CGRect)convertSubview:(UIView *)subview toTargetView:(UIView *)targetView{
   return [self convertRect:subview.frame toView:targetView];
}

- (CGRect)convertView:(UIView *)view{
    return [self convertRect:view.frame fromView:view.superview];
}


@end
