//
//  UIView+JYCommon.m
//  JYCategory
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIView+JYCommon.h"

@implementation UIView (JYCommon)

- (UIViewController *)viewController{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *) responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

- (NSString *)viewControllerName{
    UIViewController *vc = [self viewController];
    if (vc) {
        return NSStringFromClass([vc class]);
    }
    return nil;
}

+ (UINib *)nibWithName:(NSString *)name {
    return [UINib nibWithNibName:name bundle:nil];
}

+ (NSArray *)viewsWithNibName:(NSString *)name {
    return [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil];
}

- (void)setCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}

@end
