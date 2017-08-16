//
//  UIView+JYEvent.m
//  JYExtension
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIView+JYEvent.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic, copy) ActionBlock tapBlock;
@property(nonatomic, strong, readonly) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, copy) ActionBlock longPressBlock;
@property(nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end


@implementation UIView (JYEvent)

//setter方法
- (void)setParam:(NSDictionary *)param{
    objc_setAssociatedObject(self, _cmd, param, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
//getter方法
- (NSDictionary *)param{
    return objc_getAssociatedObject(self, @selector(setParam:));
}

#pragma mark - ---------------tap手势---------------
//setter方法
- (void)setTapBlock:(ActionBlock)tapBlock{
    objc_setAssociatedObject(self, _cmd, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
//getter方法
- (ActionBlock)tapBlock{
    return objc_getAssociatedObject(self, @selector(setTapBlock:));
}


- (UITapGestureRecognizer *)tapGestureRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!tapGestureRecognizer) {
        tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        objc_setAssociatedObject(self, _cmd, tapGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tapGestureRecognizer;
}


- (void)handleTapGesture:(UIGestureRecognizer *)ges{
    if (self.tapBlock) {
        self.tapBlock(self.param);
    }
}

//开启event点击事件
- (void)enableTapEvent{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)addTapActionWithBlock:(ActionBlock)tapBlock{
    self.tapBlock = tapBlock;
    [self enableTapEvent];
}

//移除所有tap手势
- (void)removeAllTapGesture{
    [[self gestureRecognizers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
            UIGestureRecognizer *recognizer = (UIGestureRecognizer *) obj;
            [self removeGestureRecognizer:recognizer];
        }
    }];
}

#pragma mark - ---------------长按手势---------------
//setter方法
- (void)setLongPressBlock:(ActionBlock)longPressBlock{
    objc_setAssociatedObject(self, _cmd, longPressBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//getter方法
- (ActionBlock)longPressBlock{
    return objc_getAssociatedObject(self, @selector(setLongPressBlock:));
}


- (UILongPressGestureRecognizer *)longPressGestureRecognizer{
    UILongPressGestureRecognizer *longPressGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!longPressGestureRecognizer) {
        longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
        longPressGestureRecognizer.minimumPressDuration = 0.8;
        objc_setAssociatedObject(self, _cmd, longPressGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return longPressGestureRecognizer;
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        if (self.longPressBlock) {
            self.longPressBlock(self.param);
        }
    }
}

//开启event长按事件
- (void)enableLongPressEvent{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.longPressGestureRecognizer];
}

- (void)addLongPressActionWithBlock:(ActionBlock)longPressBlock{
    self.longPressBlock = longPressBlock;
    [self enableLongPressEvent];
}

//移除所有长按手势
- (void)removeAllLongPressGesture{
    [[self gestureRecognizers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
            UIGestureRecognizer *recognizer = (UIGestureRecognizer *) obj;
            [self removeGestureRecognizer:recognizer];
        }
    }];
}

@end
