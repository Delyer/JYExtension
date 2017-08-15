//
//  UIView+JYLocation.h
//  JYCategory
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYLocation)

//self的subView的frame转换到目标view的frame
- (CGRect)convertSubview:(UIView *)subview toTargetView:(UIView *)targetView;

//把view在父视图的frame转换为self中的frame
- (CGRect)convertView:(UIView *)view;



@end
