//
//  UIView+JYFrame.h
//  JYCategory
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *快捷获取View的frame
 */

#import <UIKit/UIKit.h>

@interface UIView (JYFrame)

@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat centerX;
@property (nonatomic, assign, readonly) CGFloat centerY;
@property (nonatomic, assign, readonly) CGPoint origin;
@property (nonatomic, assign, readonly) CGSize jSize;

@end
