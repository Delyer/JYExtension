//
//  NSURL+JYHandle.m
//  JYCategory
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSURL+JYHandle.h"

@implementation NSURL (JYHandle)

+ (NSURL *)URLWithStringOrNil:(NSString *)URLString {
    if (URLString) {
        return [NSURL URLWithString:URLString];
    }
    return nil;
}

- (BOOL) isEqualToURL:(NSURL*)otherURL {
    return [[self absoluteURL] isEqual:[otherURL absoluteURL]] ||
    ([self isFileURL] && [otherURL isFileURL] && [[self path] isEqual:[otherURL path]]);
}

@end
