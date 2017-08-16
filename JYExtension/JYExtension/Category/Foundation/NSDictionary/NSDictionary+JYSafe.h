//
//  NSDictionary+JYSafe.h
//  JYExtension
//
//  Created by Dely on 2017/8/4.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *处理NSArray的安全操作，增删改查
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - ------------- 不可变字典 -------------
@interface NSDictionary (JYSafe)

//是否有key
- (BOOL)hasKey:(id)key;

//赋值
- (void)safeSetValue:(id)value forKey:(id)key;

//取值
- (id)safeValueForKey:(id)key;

- (NSString*)stringForKey:(id)key;
- (NSNumber*)numberForKey:(id)key;
- (NSArray*)arrayForKey:(id)key;
- (NSDictionary*)dictionaryForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (double)doubleForKey:(id)key;

//合并
+ (NSMutableDictionary *)safeDictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSMutableDictionary *)safeDictionaryByMergingWith:(NSDictionary *)dict;


//转换为json字符串
- (NSString *)safeJSONString;

//删除元素
- (NSDictionary *)safeDictionaryRemoveObjectForKey:(id)key;

//遍历字典转化修改
- (NSDictionary *)mapDictionaryUsingBlock:(id (^)(id object, NSString *key))block;

//筛选符合条件的键值对
- (NSDictionary *)filterDictionaryUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind;

//删除符合条件的元素
- (NSDictionary *)deleteDictionaryUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;

@end


#pragma mark - ------------- 可变字典 -------------
@interface NSMutableDictionary (JYSafeOperate)

//对象赋值
- (void)safeSetObject:(id)object forKey:(id)key;

//基本类型赋值
- (void)safeSetBoolObject:(BOOL)number forKey:(id)key;
- (void)safeSetIntObject:(int)number forKey:(id)key;
- (void)safeSetIntegerObject:(NSInteger)number forKey:(id)key;
- (void)safeSetUnsignedIntegerObject:(NSUInteger)number forKey:(id)key;

- (void)safeSetCharObject:(char)c forKey:(id)key;
- (void)safeSetDoubleObject:(double)number forKey:(id)key;
- (void)safeSetFloatObject:(float)number forKey:(id)key;
- (void)safeSetLongLongObject:(long long)number forKey:(id)key;

- (void)safeSetCGFloatObject:(CGFloat)f forKey:(id)key;
- (void)safeSetPointObject:(CGPoint)point forKey:(id)key;
- (void)safeSetSizeObject:(CGSize)size forKey:(id)key;
- (void)safeSetRectObject:(CGRect)rect forKey:(id)key;

//删除元素
- (void)safeRemoveObjectForKey:(id)key;

//遍历字典转化修改
- (void)mapUsingBlock:(id (^)(id object, NSString *key))block;

//筛选符合条件的键值对
- (void)filterUsingBlock:(BOOL (^) (id object, NSString *key))findBlock stopWhenFind:(BOOL)stopWhenFind;

//删除符合条件的元素
- (void)deleteUsingBlock:(BOOL (^)(id object, NSString *key))deleteBlock stopWhenDelete:(BOOL)stopWhenDelete;


@end
