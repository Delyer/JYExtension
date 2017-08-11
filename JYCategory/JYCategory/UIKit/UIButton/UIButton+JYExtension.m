//
//  UIButton+JYExtension.m
//  JYCategory
//
//  Created by Dely on 2017/8/11.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIButton+JYExtension.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, copy) CallBackBlock actionBlock;

//事件响应最小区域大小(小于此区域则放大，否则保持原大小不变，不赋值保持原大小不变，center相同)
@property (nonatomic, assign) CGSize eventFrame;

@end

@implementation UIButton (JYExtension)


#pragma mark - ----------------button添加事件block----------------
//setter
- (void)setActionBlock:(CallBackBlock)actionBlock{
    objc_setAssociatedObject(self, _cmd, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//getter
- (CallBackBlock)actionBlock{
    return objc_getAssociatedObject(self, @selector(setActionBlock:));
}

- (void)addActionHandle:(CallBackBlock)block{
    self.actionBlock = block;
    [self addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickAction:(UIButton *)sender{
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}

#pragma mark - ----------------设置button响应区域大小----------------

- (void)setEventFrame:(CGSize)eventFrame{
    NSString *eventFramStr = NSStringFromCGSize(eventFrame);
    objc_setAssociatedObject(self, _cmd, eventFramStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (CGSize)eventFrame{
    NSString *eventFramStr = objc_getAssociatedObject(self, @selector(setEventFrame:));
    return CGSizeFromString(eventFramStr);
}

- (void)setMinEventTouchSize:(CGSize)minSize{
    self.eventFrame = minSize;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event{
    CGRect bounds = self.bounds;
    CGFloat widthExtra = MAX(self.eventFrame.width - bounds.size.width, 0);
    CGFloat heightExtra = MAX(self.eventFrame.height - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthExtra, -0.5 * heightExtra);
    return CGRectContainsPoint(bounds, point);

}


@end
