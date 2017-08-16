//
//  NSString+JYCommon.m
//  JYExtension
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "NSString+JYCommon.h"
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
//注意idfa的采集是否合法。

@implementation NSString (JYCommon)

+ (NSString *)getUUID{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (idfa) {
            return idfa;
        } else {
            NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            return idfv;
        }
    } else {
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        return idfv;
    }
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainSize{
    CGSize size = CGSizeZero;
    CGRect rect = [self boundingRectWithSize:constrainSize
                                     options:NSStringDrawingTruncatesLastVisibleLine
                   | NSStringDrawingUsesFontLeading
                   | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : font}
                                     context:nil];
    size = rect.size;
    return size;
}

@end
