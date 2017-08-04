//
//  ViewController.m
//  JYCategory
//
//  Created by Dely on 2017/8/3.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "ViewController.h"
#import "FoundationController.h"
#import "UIKitController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Category";
}

- (IBAction)goToFoundationAction:(UIButton *)sender {
    FoundationController *FVC = [FoundationController new];
    [self.navigationController pushViewController:FVC animated:YES];
}

- (IBAction)goToUIKitAction:(UIButton *)sender {
    UIKitController *UVC = [UIKitController new];
    [self.navigationController pushViewController:UVC animated:YES];
}

@end
