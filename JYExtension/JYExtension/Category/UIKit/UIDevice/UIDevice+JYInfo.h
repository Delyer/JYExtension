//
//  UIDevice+JYInfo.h
//  JYExtension
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 *获取设备信息的相关方法
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NetworkType) {
    NetworkTypeUnknown = -1, //
    NetworkType2G = 0,
    NetworkType3G,
    NetworkType4G,
    NetworkTypeWifi,
    NetworkTypeLTE
};

@interface UIDevice (JYInfo)

// 屏幕宽度
+ (CGFloat)getDeviceScreenWidth;
// 屏幕高度
+ (CGFloat)getDeviceScreenHeight;

// 设备的名称
+ (NSString *)getDeviceName;

// 设备类型
+ (NSString *)getDeviceTypeName;


// 获取BundleID
+ (NSString*)getBundleID;

// app版本号
+ (NSString *)getAPPVerion;

// app_build版本号
+ (NSString *)getAPPBuildVersion;

// app名字
+ (NSString *)getAPPName;

// 设备UUID
+ (NSString *)getiPhoneUUID;

// 设备系统版本
+ (NSString *)getSystemVersion;

// 获取电池剩余电量
+ (CGFloat)getBatteryLevel;

// 获取手机IP
+ (NSString *)getDeviceIPAdress;

// 获取总内存大小(单位：字节 B)
+ (long long)getTotalMemorySize;

// 获取当前可用内存(单位：字节 B)
+ (long long)getAvailableMemorySize;

// 获取总磁盘容量(单位：字节 B)
+ (long long)getTotalDiskSize;

// 获取可用磁盘容量(单位：字节 B)
+ (long long)getAvailableDiskSize;

// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel;

// 获取当前语言
+ (NSString *)getDeviceLanguage;

// 获取运营商名称
+ (NSString *)getCarrierName;

// 获取网络类型(确保statusbar没有隐藏，否则获取不到）
+ (NetworkType)getNetworkType;

// 获取网络类型名称(确保statusbar没有隐藏，否则获取不到）
+ (NSString *)getNetworkTypeName;

@end
