//
//  JYMainThreadRun.m
//  JYExtension
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JYMainThreadRun.h"

void JYMainThreadRun(void(^run)(void)){
    dispatch_async(dispatch_get_main_queue(), ^{
        if (run) {
            run();
        }
    });
}
