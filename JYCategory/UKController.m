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
    NSLog(@"设备型号 = %@",[UIDevice getDeviceTypeName]);
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

#pragma mark - -----------------testDevice-----------------
- (IBAction)test_UIColor_JYCommon:(UIButton *)sender {
    
    //渐变颜色
    UIColor *color = [UIColor getJYGradientColorFromColor:[UIColor redColor] toColor:[UIColor purpleColor] withHeight:[UIDevice getDeviceScreenHeight]];
    self.view.backgroundColor = color;
    
}

#pragma mark - -----------------testUIAlertView-----------------
- (IBAction)test_UIAlertView_JYBlock:(UIButton *)sender {
    
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {

        NSLog(@"你点击的索引为%ld",buttonIndex);
     
    } title:@"你好" message:@"hello world" cancelButtonTitle:@"取消" otherButtonTitles:@"11",@"22"@"33", nil];
    
    
}

@end
