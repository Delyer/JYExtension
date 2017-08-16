//
//  UIView+JYEvent.h
//  JYExtension
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 * 给不能响应touch事件的View添加点击或者长按事件(如UIView,UIImageView,UILabel...)
 */

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(NSDictionary *param);

@interface UIView (JYEvent)

//如果需要传参，请给param赋值
@property(nonatomic, copy) NSDictionary *param;

//添加tap手势
- (void)addTapActionWithBlock:(ActionBlock)tapBlock;
//移除所有tap手势
- (void)removeAllTapGesture;

//添加长按手势
- (void)addLongPressActionWithBlock:(ActionBlock)longPressBlock;
//移除所有长按手势
- (void)removeAllLongPressGesture;

@end
