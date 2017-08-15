//
//  UIButton+JYExtension.h
//  JYCategory
//
//  Created by Dely on 2017/8/11.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock)(UIButton * button);

@interface UIButton (JYExtension)

//button添加事件block
- (void)addActionHandle:(CallBackBlock)block;

//设置button响应区域大小(小于此区域则放大，否则保持原大小不变，不赋值保持原大小不变，center相同)
- (void)setMinEventTouchSize:(CGSize)minSize;


@end
