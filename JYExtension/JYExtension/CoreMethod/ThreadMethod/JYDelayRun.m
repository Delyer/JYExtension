//
//  JYDelayRun.m
//  JYExtension
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JYDelayRun.h"

void JYDelayRun(NSTimeInterval delay,void(^run)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (run) {
            run();
        }
    });
}
