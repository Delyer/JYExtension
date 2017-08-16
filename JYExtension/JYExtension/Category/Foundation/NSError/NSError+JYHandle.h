//
//  NSError+JYHandle.h
//  JYExtension
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (JYHandle)

//新建error
+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description
               failureReason:(NSString *)failReason;
+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description;

//获取error信息
- (NSString *)getErrorDomain;
- (NSInteger)getErrorCode;
- (NSString *)getErrorDescription;
- (NSString *)getErrorReason;

@end
