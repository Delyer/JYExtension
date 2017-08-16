//
//  NSMutableArray+JYSafe.m
//  JYExtension
//
//  Created by Dely on 16/5/18.
//  Copyright © 2016年 Dely. All rights reserved.
//

#import "NSMutableArray+JYSafe.h"
#import "NSArray+JYSafe.h"

@implementation NSMutableArray (JYSafe)

//添加id数组元素
- (void)safeAddObject:(id)object {
    if (object) {
        [self addObject:object];
    }
}

//从数组里添加元素
- (void)safeAddObjectsFromArray:(NSArray *)array {
    if (array) {
        [self addObjectsFromArray:array];
    }
}

//插入元素
- (void)safeInsertObject:(id)object atIndex:(NSInteger)index {
    if (object && (self.count > index) && index>=0) {
        [self insertObject:object atIndex:index];
    }
}
//替换
- (void)safeReplaceObjectAtIndex:(NSInteger)index  withObject:(id)object
{
    if (object&&(self.count>index)&&index>=0) {
        [self replaceObjectAtIndex:index withObject:object];
    }
}

//添加基本类型数组元素
- (void)safeAddObjectWithInteger:(NSInteger)number {
    [self safeAddObject:@(number)];
}

- (void)safeAddObjectWithDouble:(double)number {
    [self safeAddObject:@(number)];
}

- (void)safeAddObjectWithFloat:(float)number {
    [self safeAddObject:@(number)];
}

- (void)safeAddObjectWithLong:(long long)number {
    [self safeAddObject:@(number)];
}

- (void)safeAddObjectWithRang:(NSRange)rang{
    [self safeAddObject:NSStringFromRange(rang)];
}

- (void)safeAddObjectWithRect:(CGRect)rect{
    [self safeAddObject:NSStringFromCGRect(rect)];
}

- (void)safeAddObjectWithPoint:(CGPoint)point{
    [self safeAddObject:NSStringFromCGPoint(point)];
}

- (void)safeAddObjectWithSize:(CGSize)size{
    [self safeAddObject:NSStringFromCGSize(size)];
}

//删除元素
- (void)safeRemoveObjectAtIndex:(NSInteger)index {
    
    if ((self.count > index) && (index >= 0)) {
        [self removeObjectAtIndex:index];
    }
}

//转换
- (void)mapUsingBlock:(id (^)(id, NSInteger))block {

    if (block) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array safeAddObject:block(obj, idx)];
        }];
        [self removeAllObjects];
        [self safeAddObjectsFromArray:[array copy]];
    }
}

//筛选
- (void)filterUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (findBlock(obj)) {
                [array safeAddObject:obj];
                *stop = stopWhenFind;
            }
        }];
        [self removeAllObjects];
        [self safeAddObjectsFromArray:[array copy]];
    }
}

//删除符合条件的元素
- (void)deleteUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (deleteBlock(obj)) {
                [array safeAddObject:obj];
                *stop = stopWhenDelete;
            }
        }];
        [self removeObjectsInArray:[array copy]];
    }
}


//重组数组(打乱顺序)
- (void)shuffle {
    NSMutableArray *copy = [self mutableCopy];
    [self removeAllObjects];
    
    while (copy.count > 0) {
        int index = arc4random() % copy.count;
        id objectToMove = [copy safeObjectAtIndex:index];
        [self safeAddObject:objectToMove];
        [copy safeRemoveObjectAtIndex:index];
    }
}

//数组倒序
- (void)reverse {
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    [self removeAllObjects];
    [self safeAddObjectsFromArray:reversedArray];
}

//数组去重
- (void)unique {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([array containsObject:obj] == NO){
            [array addObject:obj];
        }
    }];
    [self removeAllObjects];
    [self safeAddObjectsFromArray:[array mutableCopy]];
}

@end
