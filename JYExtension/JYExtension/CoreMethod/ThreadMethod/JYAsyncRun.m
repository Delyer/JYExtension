//
//  JYAsyncRun.m
//  JYExtension
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JYAsyncRun.h"

void JYAsyncRun(void(^run)(void)){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (run) {
            run();
        }
    });
}
