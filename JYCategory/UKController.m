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
    NSLog(@"bundleID = %@",[UIDevice getBundleID]);
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
    NSLog(@"运营商 = %@",[UIDevice getCarrierName]);
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

#pragma mark - -----------------testUIView-----------------
- (IBAction)test_UIView_JYEvent:(UIButton *)sender{
    //给self.view传参数和添加点击事件
    self.view.param = @{@"1":@"one"};
    [self.view addTapActionWithBlock:^(NSDictionary *param) {
        NSLog(@"你点击了self.view,param = %@",param);
        //自定义处理事件
    }];
    

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIDevice getDeviceScreenHeight] - 50, 50, 50)];
    imageView.backgroundColor = [UIColor purpleColor];
    imageView.tag = 100;
    [self.view addSubview:imageView];
    
    //给imageView添加点击事件
    imageView.param = @{@"param":@"这是参数"};
    [imageView addTapActionWithBlock:^(NSDictionary *param) {
        NSLog(@"你点击了imageView,param = %@",param);
        //自定义处理事件
    }];
    
    //给imageView添加长按事件
    [imageView addLongPressActionWithBlock:^(NSDictionary *param) {
        NSLog(@"你长按了imageView,param = %@",param);
        //自定义处理事件
    }];
    
    [UIAlertView alertWithCallBackBlock:nil title:nil message:@"请点击self.view或者imageView即可触发点击事件" cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

- (IBAction)test_UIView_JYFrame:(UIButton *)sender{
    UIView *view = self.view;
    NSLog(@"上 = %f，左 = %f，下 = %f，右 = %f, 宽 = %f, 高 = %f,中心x = %f,中心y = %f",view.top,view.left,view.bottom,view.right,view.width,view.height,view.centerX,view.centerY);
    
    NSLog(@"self.View所在的viewController = %@",[self.view viewController]);
    NSLog(@"self.View所在的viewControllerName = %@",[self.view viewControllerName]);
    
    //设置圆角
    [self.view setCornerRadius:5 borderWidth:1 borderColor:[UIColor redColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, [UIDevice getDeviceScreenHeight] - 50, 50, 50)];
    imageView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:imageView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [imageView addSubview:view1];
    
    NSLog(@"目标转换坐标 = %@",NSStringFromCGRect([imageView convertSubview:view1 toTargetView:self.view]));
    NSLog(@"目标转换坐标 = %@",NSStringFromCGRect([self.view convertView:view1]));

}


#pragma mark - -----------------testUIButton-----------------
- (IBAction)test_UIButton_JYExtension:(UIButton *)sender{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(200, [UIDevice getDeviceScreenHeight] - 50, 80, 30);
    [button setTitle:@"点击周围" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    //添加点击事件
    [button addActionHandle:^(UIButton *button) {
        NSLog(@"点击了按钮~");
    }];
    
    //设置最小响应区域大小
    [button setMinEventTouchSize:CGSizeMake(130, 100)];
    
}

#pragma mark - -----------------testImage-----------------
- (IBAction)test_UIImage_JYHandle:(UIButton *)sender{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIDevice getDeviceScreenHeight] - 150, 150, 150)];
    [self.view addSubview:imageView];
    
    UIImage *image = [UIImage imageNamed:@"1"];
    //对图片加水印
    imageView.image = [UIImage waterMarkWithImage:image markImage:image location:CGRectMake(50, 50, 150, 150)];
    
    //等比缩放
    imageView.image = [UIImage scaleImage:image toScale:0.1];
    
    //自定义剪切
    imageView.image = [UIImage customCutImage:image AtRect:CGRectMake(1000, 500, 500, 500)];
    
    //自定义旋转后的图片
    imageView.image = [UIImage customImageRotate:image rotatedRadians:M_PI/4.0];
    UIViewController *vc = [UIWindow getCurrentVC];
    
    NSLog(@"当前vc = %@",vc);
}


@end
