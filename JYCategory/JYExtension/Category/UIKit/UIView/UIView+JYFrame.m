//
//  UIView+JYFrame.m
//  JYCategory
//
//  Created by Dely on 2017/8/10.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIView+JYFrame.h"

@implementation UIView (JYFrame)


- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)centerX{
    return self.center.x;
}
- (CGFloat)centerY{
    return self.center.y;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (CGSize)jSize{
    return self.frame.size;
}


@end
