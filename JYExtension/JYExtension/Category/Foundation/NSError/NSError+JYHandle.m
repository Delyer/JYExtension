//
//  NSError+JYHandle.m
//  JYExtension
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSError+JYHandle.h"

@implementation NSError (JYHandle)

+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description {
    
    NSError *error = [NSError errorWithDomain:domain
                                          code:code
                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description,NSLocalizedDescriptionKey,nil]];
    return error;
}


+ (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description
               failureReason:(NSString *)failureReason {
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description, NSLocalizedDescriptionKey,
                                                                          failureReason, NSLocalizedFailureReasonErrorKey,nil]];
    return error;
}

- (NSString *)getErrorDomain{
    return [self domain];
}
- (NSInteger)getErrorCode{
    return [self code];
}
- (NSString *)getErrorDescription{
    return [self localizedDescription];
}
- (NSString *)getErrorReason{
    return [self localizedFailureReason];
}

@end
