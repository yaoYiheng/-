//
//  UIView+Frame.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x{

    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)Height{
    CGRect frame = self.frame;
    frame.size.height = Height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)Width{
    CGRect frame = self.frame;
    frame.size.width = Width;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (CGFloat)Height{
    return self.frame.size.height;
}
- (CGFloat)Width{
    return self.frame.size.width;

}
@end
