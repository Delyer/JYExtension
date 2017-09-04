//
//  UIViewController+JYVCName.h
//  JYExtension
//
//  Created by Dely on 2017/9/4.
//  Copyright © 2017年 Dely. All rights reserved.
//

/*
 应用背景：我们在查找一个项目的viewController比较耗时，我们打印出来当前的VC，方便我们修改更新代码
 方式1：新建基类VC，然后继承于基类VC，然后重写基类中的viewWillAppear方法（耦合性高）
 方式2：给VC建立一个分类，在分类里进行方法的交换，既保留了原本的方法，又有打印信息
 */

#import <UIKit/UIKit.h>

@interface UIViewController (JYVCName)

@end
