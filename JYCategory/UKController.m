//
//  UKController.m
//  JYCategory
//
//  Created by Dely on 2017/8/9.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UKController.h"
#import "JYCategory.h"

@interface UKController ()

@end

@implementation UKController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - -----------------testDevice-----------------
- (IBAction)test_UIDevice_JYInfo:(UIButton *)sender {
    
    NSLog(@"屏幕宽和高 w = %f, h = %f",[UIDevice getDeviceScreenWidth],[UIDevice getDeviceScreenHeight]);
    NSLog(@"设备的名字 = %@",[UIDevice getDeviceName]);
    NSLog(@"app版本号 = %@",[UIDevice getAPPVerion]);
    NSLog(@"app_build版本号 = %@",[UIDevice getAPPBuildVersion]);
    NSLog(@"appName = %@",[UIDevice getAPPName]);
    NSLog(@"iPhoneUUID = %@",[UIDevice getiPhoneUUID]);
    NSLog(@"设备系统版本 = %@", [UIDevice getSystemVersion]);
    
    NSLog(@"设备电量 = %f",[UIDevice getCurrentBatteryLevel]);
    NSLog(@"设备ip = %@",[UIDevice getDeviceIPAdress]);
    
    NSLog(@"设备总内存大小 = %lld",[UIDevice getTotalMemorySize]);
    NSLog(@"当前可用内存 = %lld",[UIDevice getAvailableMemorySize]);
    NSLog(@"设备总磁盘容量 = %lld",[UIDevice getTotalDiskSize]);
    NSLog(@"可用磁盘容量 = %lld",[UIDevice getAvailableDiskSize]);
    NSLog(@"当前语言 = %@",[UIDevice getDeviceLanguage]);
}


@end
