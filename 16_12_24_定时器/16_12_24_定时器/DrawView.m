//
//  DrawView.m
//  16_12_24_定时器
//
//  Created by 姚懿恒 on 2016/12/24.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
- (void)awakeFromNib{
    [super awakeFromNib];
    //调用该方法会使动画效果越来越卡
    [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(changeY) userInfo:nil repeats:YES];

    //使用CADisplayLink时,它的定时器方法就是屏幕每次刷新的时候就会调用(通常屏幕一秒钟刷新60次)
    //它和setNeedsDisplay调用DrawRect方法的时机正好吻合,不会出间等待间隔.不会出现屏幕卡顿现象.
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeY)];
    //添加到主循环.
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];



}
static float starY = 0;
- (void)changeY{
    starY += 10;
    if (starY > [UIScreen mainScreen].bounds.size.height) {
        starY = 0;
    }
    [self setNeedsDisplay];

}

- (void)drawRect:(CGRect)rect{
    UIImage *image  = [UIImage imageNamed:@"1_jpg.png"];
    [image drawAtPoint:CGPointMake(0 , starY)];
    
}
@end
