//
//  JYDeviceMacro.h
//  JYCategory
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#ifndef JYDeviceMacro_h
#define JYDeviceMacro_h

// ----------------------  DEBUG 模式打印设置  ---------------------/
#ifdef DEBUG
#define DLog(format, ...) NSLog(format, ##__VA_ARGS__)
#else
#define DLog(format, ...)
#endif

#ifdef DEBUG
#define CLog(fmt, ...) NSLog((@"文件位置=%s 方法=%s 行数=%d 打印结果=" fmt),__FILE__, __PRETTY_FUNCTION__,__LINE__, ##__VA_ARGS__);
#else
#define CLog(...)
#endif

// ----------------------  系统版本判断  ---------------------/

#define SYS_VERSION [[UIDevice currentDevice] systemVersion]

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

#define IOS9_OR_EARLIER (!IOS10_OR_LATER)
#define IOS8_OR_EARLIER (!IOS9_OR_LATER)
#define IOS7_OR_EARLIER (!IOS8_OR_LATER)
#define IOS6_OR_EARLIER (!IOS7_OR_LATER)

// ----------------------  App 信息获取  ---------------------/
// 屏幕宽、高、尺寸
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

//6/6s/7 --667  6p/6ps/7ps ---736     5/5s --568   4s --480
#define IPHONE_4_4S       [@(SCREEN_HEIGHT) compare:@(480)] == NSOrderedSame
#define IPHONE_5_5S       [@(SCREEN_HEIGHT) compare:@(568)] == NSOrderedSame
#define IPHONE_6P_6PS_7PS [@(SCREEN_HEIGHT) compare:@(736)] == NSOrderedSame
#define IPHONE_6_6S_7     [@(SCREEN_HEIGHT) compare:@(667)] == NSOrderedSame

#endif /* JYDeviceMacro_h */
