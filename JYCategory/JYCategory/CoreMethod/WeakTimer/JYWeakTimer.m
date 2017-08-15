//
//  JYWeakTimer.m
//  JYCarousel
//
//  Created by Dely on 16/11/17.
//  Copyright © 2016年 Dely. All rights reserved.
//

#import "JYWeakTimer.h"

@interface JYWeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

@end


@implementation JYWeakTimerTarget

- (void) fire:(NSTimer *)timer {
    if(self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f inModes:@[NSRunLoopCommonModes]];
#pragma clang diagnostic pop
    } else {
        [self.timer invalidate];
    }
}

@end

@implementation JYWeakTimer


+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats {
    JYWeakTimerTarget *timerTarget = [[JYWeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    
    return timerTarget.timer;
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(JYTimerBlock)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats{
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfoArray addObject:userInfo];
    }
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(timerCallBackBlock:)
                                       userInfo:[userInfoArray copy]
                                        repeats:repeats];
}

- (void)timerCallBackBlock:(NSArray*)userInfo {
    if (userInfo.count > 0) {
        JYTimerBlock block = userInfo[0];
        id info = nil;
        if (userInfo.count == 2) {
            info = userInfo[1];
        }
        if (block) {
            block(info);
        }
    }
}


@end
