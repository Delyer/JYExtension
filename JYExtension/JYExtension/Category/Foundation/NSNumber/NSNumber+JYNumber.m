//
//  NSNumber+JYNumber.m
//  JYExtension
//
//  Created by Dely on 2017/8/14.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSNumber+JYNumber.h"

static NSNumberFormatter *numberFormatter = nil;

@implementation NSNumber (JYNumber)

+ (NSNumber *)numberWithString:(NSString *)string {
    if(numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    
    if (string) {
        @try {
            return [numberFormatter numberFromString:string];
        }
        @catch (NSException * e) {
            NSLog(@"NSNumberFormatter exception! parsing: %@", string);
        }
    }
    return nil;
}

@end
