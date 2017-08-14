//
//  NSURL+JYHandle.h
//  JYCategory
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (JYHandle)

//创建一个url
+ (NSURL *)URLWithStringOrNil:(NSString *)URLString;
//url是否相同
- (BOOL) isEqualToURL:(NSURL*)otherURL;

@end
