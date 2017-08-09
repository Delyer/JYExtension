//
//  UIDevice+JYInfo.m
//  JYCategory
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIDevice+JYInfo.h"
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#import <objc/runtime.h>
#import <sys/mount.h>

@implementation UIDevice (JYInfo)

// 屏幕宽度
+ (CGFloat)getDeviceScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
// 屏幕高度
+ (CGFloat)getDeviceScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

// 设备的名称
+ (NSString *)getDeviceName {
    return [UIDevice currentDevice].name;
}

// 获取app版本号
+ (NSString *)getAPPVerion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

// app_build版本号
+ (NSString *)getAPPBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

// app名字
+ (NSString *)getAPPName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

// 设备UUID
+ (NSString *)getiPhoneUUID{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}
// 设备操作系统版本
+ (NSString *)getSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

// 获取电池剩余电量
+ (CGFloat)getBatteryLevel {
    return [UIDevice currentDevice].batteryLevel;
}

// 获取手机IP
+ (NSString *)getDeviceIPAdress {
    NSString *address;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

// 获取总内存大小
+ (long long)getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

// 获取当前可用内存
+ (long long)getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

// 获取总磁盘容量
+ (long long)getTotalDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0){
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

// 获取可用磁盘容量
+ (long long)getAvailableDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0){
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel {
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                            
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    return 0;
}

// 获取当前语言
+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray firstObject];
}


@end
