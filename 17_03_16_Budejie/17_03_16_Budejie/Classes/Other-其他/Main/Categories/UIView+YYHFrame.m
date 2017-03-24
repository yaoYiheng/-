//
//  UIView+YYHFrame.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIView+YYHFrame.h"

@implementation UIView (YYHFrame)
- (CGFloat)yyh_x{
    return self.bounds.origin.x;
}

- (void)setYyh_x:(CGFloat)yyh_x{
    CGRect rect = self.frame;
    rect.origin.x = yyh_x;
    self.frame = rect;
}

- (CGFloat)yyh_y{
    return self.bounds.origin.x;
}

- (void)setYyh_y:(CGFloat)yyh_y{
    CGRect rect = self.frame;
    rect.origin.y = yyh_y;
    self.frame = rect;
}

- (CGFloat)yyh_width{
    return self.bounds.size.width;
}

- (void)setYyh_width:(CGFloat)yyh_width{
    CGRect rect = self.frame;
    rect.size.width = yyh_width;
    self.frame = rect;
}

- (CGFloat)yyh_height{
    return self.bounds.size.height;
}

- (void)setYyh_height:(CGFloat)yyh_height{
    CGRect rect = self.frame;
    rect.size.height = yyh_height;
    self.frame = rect;
}

- (void)setYyh_centerX:(CGFloat)yyh_centerX{
    CGPoint center = self.center;
    center.x = yyh_centerX;
    self.center = center;

}
- (void)setYyh_centerY:(CGFloat)yyh_centerY{
    CGPoint center = self.center;
    center.y = yyh_centerY;
    self.center = center;
}
- (CGFloat)yyh_centerX{
    return self.center.x;

}
- (CGFloat)yyh_centerY{
    return self.center.y;
}

@end
