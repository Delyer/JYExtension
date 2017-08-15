//
//  UIApplication+JYHandle.h
//  JYCategory
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JYPrefsType) {
    JYPrefsWiFi = 0,            //无限局域网
    JYPrefsBluetooth,           //蓝牙
    JYPrefsMobileData,          //蜂窝移动网络
    JYPrefsInternetTethering,   //个人热点
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs
    JYPrefs

    
};

@interface UIApplication (JYHandle)

// 应用程序之间跳转(如调起电话：tel://1234567890 )
+ (void)quickOpenURLString:(NSString *)urlString;

//跳转到系统设置页面
+ (void)goToSystemSetting;

// 跳转到app设置页面
+ (void)goToSetting;

// 拨打电话
+ (void)goToTelephone:(NSString *)telephone;

// 无线局域网
+ (void)goToWifi;



@end
