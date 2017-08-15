//
//  NSObject+encode.h
//  RunTime
//
//  Created by Dely on 2017/5/16.
//  Copyright © 2017年 Dely. All rights reserved.
//
//Runtime归档解档

#import <Foundation/Foundation.h>

@interface NSObject (encode)

//归档
- (void)encodeObjectWithCoder:(NSCoder *)aCoder;

//解档
- (void)decodeObjectCoder:(NSCoder *)aDecoder;

@end
