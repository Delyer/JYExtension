//
//  NSString+JYCommon.h
//  JYCategory
//
//  Created by Dely on 2017/8/7.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JYCommon)

//设备唯一标识符
+ (NSString *)getUUID;

//获取字符串所占size(font,限制最大size)
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainSize;

@end
