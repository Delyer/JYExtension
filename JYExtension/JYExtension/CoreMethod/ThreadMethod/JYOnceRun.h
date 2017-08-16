//
//  JYOnceRun.h
//  JYExtension
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <Foundation/Foundation.h>

//执行一次
FOUNDATION_EXPORT void JYOnceRun(dispatch_once_t *onceToken,void(^run)(void));
