////
////  DrawView.m
////  16_12_24_定时器
////
////  Created by 姚懿恒 on 2016/12/24.
////  Copyright © 2016年 姚懿恒. All rights reserved.
////
//
//#import "DrawView.h"
//
//@implementation DrawView
//
//
//- (void)drawRect:(CGRect)rect{
//    //1. 获取上下文
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//
//    //2.创建路径对象
//    UIBezierPath *path = [UIBezierPath bezierPath];
//
//    //3. 绘制一条到中心的线,
//    [path moveToPoint:CGPointZero];
//    [path addLineToPoint:self.center];
//    CGContextAddPath(currentContext, path.CGPath);
//    CGContextStrokePath(currentContext);
//
//    //4. 将当前状态保存到上下文栈中.
//    CGContextSaveGState(currentContext);
//    /**
//     执行效果为, 一条到中点的黑细线
//     */
//
//    //5. 设置线宽及颜色.
//    CGContextSetRGBStrokeColor(currentContext, 1, 0, 1, 1);
//    CGContextSetLineWidth(currentContext, 10);
//
//
//    UIBezierPath *path2 = [UIBezierPath bezierPath];
//    [path2 moveToPoint:self.center];
//    [path2 addLineToPoint:CGPointMake(200, 0)];
//
//    CGContextAddPath(currentContext, path2.CGPath);
//    CGContextStrokePath(currentContext);
//    /**
//     执行效果为一条带有颜色的宽线从中点到顶点
//     */
//
//    UIBezierPath *path3 = [UIBezierPath bezierPath];
//    [path3 moveToPoint:self.center];
//    [path3  addLineToPoint:CGPointMake(377, 0)];
//    CGContextAddPath(currentContext, path3.CGPath);
//    //从上下文栈中取出之前保存的状态.
//    CGContextRestoreGState(currentContext);
//    CGContextStrokePath(currentContext);
//    /**
//     之前保存在上下文栈中的文字状态为默认状态, 所以该线也成默认状态绘制出来.
//     
//     Merry Xmas :)
//     */
//
//    UIBezierPath *path4 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200,200, 200, 100)];
//    [[UIColor orangeColor] set];
//
//    //平移: 在原基础上位移 所设置的数值
////    CGContextTranslateCTM(currentContext, 0, 300);
//
//    //旋转
////    CGContextRotateCTM(currentContext, M_PI_4);
//
//    //缩放
//    CGContextScaleCTM(currentContext, 0.1, 0.1);
//
//
//    CGContextAddPath(currentContext, path4.CGPath);
//    CGContextFillPath(currentContext);
//
//
//}
////- (void)awakeFromNib{
////    [super awakeFromNib];
////    //调用该方法会使动画效果越来越卡
////    [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(changeY) userInfo:nil repeats:YES];
////
////    //使用CADisplayLink时,它的定时器方法就是屏幕每次刷新的时候就会调用(通常屏幕一秒钟刷新60次)
////    //它和setNeedsDisplay调用DrawRect方法的时机正好吻合,不会出间等待间隔.不会出现屏幕卡顿现象.
////    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeY)];
////    //添加到主循环.
////    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
////
////
////
////}
////static float starY = 0;
////- (void)changeY{
////    starY += 10;
////    if (starY > [UIScreen mainScreen].bounds.size.height) {
////        starY = 0;
////    }
////    [self setNeedsDisplay];
////
////}
////
////- (void)drawRect:(CGRect)rect{
////    UIImage *image  = [UIImage imageNamed:@"1_jpg.png"];
////    [image drawAtPoint:CGPointMake(0 , starY)];
////    
////}
//@end
