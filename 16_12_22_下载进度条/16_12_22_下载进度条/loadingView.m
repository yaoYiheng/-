//
//  loadingView.m
//  16_12_22_下载进度条
//
//  Created by 姚懿恒 on 2016/12/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "loadingView.h"

@implementation loadingView

- (void)drawRect:(CGRect)rect{
    //获取上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //创建路径
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = self.progressValue * M_PI * 2 + startAngle;
    NSLog(@"%f", endAngle);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    [path addLineToPoint:center];
    [[UIColor colorWithRed:0.6 green:0.8 blue:0.8 alpha:0.7] set];
    //添加到上下文中
    CGContextAddPath(currentContext, path.CGPath);
    //添加一条到中点的线后实现fill方法可做到扇形效果
    CGContextFillPath(currentContext);
}
- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    
    [self setNeedsDisplay];
}

@end
