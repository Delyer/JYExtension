//
//  JYOnceRun.m
//  JYExtension
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "JYOnceRun.h"

void PGOnceRun(dispatch_once_t *onceToken,void(^run)(void)){
    dispatch_once(onceToken, ^{
        if (run) {
            run();
        }
    });
}

