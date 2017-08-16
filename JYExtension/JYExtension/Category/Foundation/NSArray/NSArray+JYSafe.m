//
//  NSArray+JYSafe.m
//  JYExtension
//
//  Created by Dely on 16/5/18.
//  Copyright © 2016年 Dely. All rights reserved.
//

#import "NSArray+JYSafe.h"

#pragma mark - ------------- 不可变数组 -------------
@implementation NSArray (JYSafe)

+ (BOOL)isEmptyWithArray:(NSArray *)array {
    if (array && (array.count > 0)) {
        return NO;
    }
    return YES;
}

- (id)safeObjectAtIndex:(NSInteger)index {
    if ((self.count > index) && (index >= 0)) {
        id obj = [self objectAtIndex:index];
        if (![obj isKindOfClass:[NSNull class]]) {
            return obj;
        }
    }
    NSLog(@"注意-------------->数组越界");
    return nil;
}

//取随机元素
- (id)randomObject {
    if (self && self.count > 0) {
        NSInteger index = arc4random() % self.count;
        return [self safeObjectAtIndex:index];
    }
    return nil;
}

//添加
- (NSMutableArray *)safeAddObject:(id)object {
    NSMutableArray *mutArray = [NSMutableArray array];
    
    if (self) {
        [mutArray safeAddObjectsFromArray:self];
    }
    [mutArray safeAddObject:object];
    return mutArray;

}
//删除元素
- (NSMutableArray *)safeArrayRemoveObjectAtIndex:(NSInteger)index {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    [array safeRemoveObjectAtIndex:index];
    return array;
}

//转换
- (NSArray *)mapArrayUsingBlock:(id (^)(id, NSInteger))block {
    
    if (block) {
        __block NSMutableArray *array = [NSMutableArray array];
        
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array safeAddObject:block(obj, idx)];
        }];
        return [array copy];
    }
    return self;
}

//筛选
- (NSArray *)filterArrayUsingBlock:(BOOL (^) (id object))findBlock stopWhenFind:(BOOL)stopWhenFind {
    
    if (findBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (findBlock(obj)) {
                [array safeAddObject:obj];
                *stop = stopWhenFind;
            }
        }];
        
        return [array copy];
    }
    return self;
}

//删除符合条件的元素
- (NSArray *)deleteArrayUsingBlock:(BOOL (^)(id object))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete {
    
    if (deleteBlock) {
        __block NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *mutArray = [NSMutableArray array];
        [mutArray safeAddObjectsFromArray:self];
        
        [mutArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (deleteBlock(obj)) {
                [array safeAddObject:obj];
                *stop = stopWhenDelete;
            }
        }];
        [mutArray removeObjectsInArray:[array copy]];
        return [mutArray copy];
    }
    
    return self;
}

//数组乱序
- (NSArray *)shuffledArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    NSMutableArray *copy = [self mutableCopy];
    while (copy.count > 0)
    {
        NSInteger index = arc4random() % copy.count;
        id objectToMove = [copy objectAtIndex:index];
        [array addObject:objectToMove];
        [copy removeObjectAtIndex:index];
    }
    return [array copy];
}

//数组倒序
- (NSArray *)reversedArray {
    NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
    return reversedArray;
}

//数组去重
- (NSArray *)uniqueArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([array containsObject:obj] == NO){
            [array addObject:obj];
        }
    }];
    return [array copy];
}

@end


#pragma mark - ------------- 不可变数组 -------------
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
