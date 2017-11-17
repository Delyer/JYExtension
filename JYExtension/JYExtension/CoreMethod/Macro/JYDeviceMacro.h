//
//  JYDeviceMacro.h
//  JYExtension
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

#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

#define IOS10_OR_EARLIER (!IOS11_OR_LATER)
#define IOS9_OR_EARLIER (!IOS10_OR_LATER)
#define IOS8_OR_EARLIER (!IOS9_OR_LATER)
#define IOS7_OR_EARLIER (!IOS8_OR_LATER)
#define IOS6_OR_EARLIER (!IOS7_OR_LATER)

// ----------------------  App 信息获取  ---------------------/
// 屏幕宽、高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

//机型  6/6s/7/8 --667  6p/6sp/7sp/8p ---736     5/5s --568   4s --480  x --812
#define IPHONE_4_4S             [@(SCREEN_HEIGHT) compare:@(480)] == NSOrderedSame
#define IPHONE_5_5S_5C_SE       [@(SCREEN_HEIGHT) compare:@(568)] == NSOrderedSame
#define IPHONE_6_6S_7_8         [@(SCREEN_HEIGHT) compare:@(667)] == NSOrderedSame
#define IPHONE_6P_6SP_7SP_8P    [@(SCREEN_HEIGHT) compare:@(736)] == NSOrderedSame
#define IPHONE_X                ([@(SCREEN_HEIGHT) compare:@(812)] == NSOrderedSame)

//屏幕尺寸 3.5/4.0/4.7/5.5/5.8 inch
#define IPHONEINCH_35 IPHONE_4_4S
#define IPHONEINCH_40 IPHONE_5_5S_5C_SE
#define IPHONEINCH_47 IPHONE_6_6S_7_8
#define IPHONEINCH_55 IPHONE_6P_6SP_7SP_8P
#define IPHONEINCH_58 IPHONE_X

//导航栏高度
#define NAVIGATION_HEIGHT (IPHONE_X?88:64)
//状态栏高度
#define STATUSBAR_HEIGHT (IPHONE_X?44:20)
//安全区域以外高度
#define SAFEEXTRAHEIGHT (IPHONE_X?24:0)


#endif /* JYDeviceMacro_h */
