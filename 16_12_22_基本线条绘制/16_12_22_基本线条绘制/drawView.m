//
//  drawView.m
//  16_12_22_基本线条绘制
//
//  Created by 姚懿恒 on 2016/12/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "drawView.h"
@interface drawView()
/** 颜色*/
@property (nonatomic, strong) UIColor *circleColor;

@end
@implementation drawView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [super drawRect:rect];
//    [self drawQuadCurve];
//    [self drwrect];
//    [self drawHalfCircle];
    [self draw];

}
#pragma mark 画椭圆
- (void)draw{
    CGFloat radius = 100;
    CGPoint center;
    center.x = self.bounds.size.width / 2;
    center.y = self.bounds.size.height / 2;

    //调用该方法画椭圆
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 100, 60)];
//    [path stroke];

    //绘制弧度以及扇形
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(200, 250)];
    [path addLineToPoint:center];

    //可调用该方法封闭未完成的图形
    [path closePath];


    [path stroke];

}

#pragma mark 画矩形
- (void) drwrect{

    //绘制带圆角的矩形
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 1, 0, 1, 1);
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(150, 150, 50, 50) cornerRadius:10];

    CGContextAddPath(currentContext, path1.CGPath);
    CGContextFillPath(currentContext);

    //绘制不带圆角的矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 100)];
    [[UIColor orangeColor] set];
    [path stroke];
}
#pragma mark 画曲线
- (void)drawQuadCurve{
    //1.获取上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    //2.创建路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];

    //3.设置起点
    [path moveToPoint:CGPointMake(20, 200)];
    //设置曲线的终点, 以及控制点, 用来控制曲线的弯曲.
    [path addQuadCurveToPoint:CGPointMake(280, 200) controlPoint:CGPointMake(0, 0)];
    //UIKit path -> CoreGraphics Path
    CGContextAddPath(currentContext, path.CGPath);

    CGContextStrokePath(currentContext);
}
#pragma mark 画直线.
- (void)drawLine{
    //拿到当前view上下文.
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetRGBFillColor(context, 1, 0, 1, 1);
    CGContextSetLineWidth(context, 10);
    //设置线的连接样式.
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    //设置线的顶角样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //创建path creates a mutable graphics path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 20, 30);
    CGPathAddLineToPoint(path, NULL, 280, 30);


    CGContextAddPath(context, path);

    /**
     带有Ref后缀的类型的对象可能具有指向其他CoreGraphics"对象"的强引用指针, 并成为这些
     "对象"的拥有者.但是ARC无法识别这类强引用和对象的所有权, 必须在使用完之后手动释放.
     规则是, 如果使用名称中带有create 或者copy的函数创建了一个CoreGraphics对象, 就
     必须调用对应的Release函数, 并传入该对象指针.
     */
    CGContextStrokePath(context);
    CGPathRelease(path);


        /**********这两段代码的效果是相同的************/

    /**
     把路径添加到上下文当中.
     UIKit path -> CoreGraphics Path
     CGContextAddPath(context, path.CGPath);
     */

    [[UIColor colorWithRed:1 green:0 blue:1 alpha:1] setStroke];

    UIBezierPath *path_1 = [UIBezierPath bezierPath];
    [path_1 moveToPoint:CGPointMake(20, 50)];
    [path_1 addLineToPoint:CGPointMake(280, 50)];
    //设置宽度, 顶角样式, 与连接样式
    [path_1 setLineWidth:10];
    [path_1 setLineCapStyle:kCGLineCapRound];
    [path_1 setLineJoinStyle:kCGLineJoinRound];
    //绘制
    [path_1 stroke];


}
#pragma mark  画变色半圆
- (void)drawHalfCircle{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    UIBezierPath *path2 = [UIBezierPath bezierPath];

    CGFloat radius = 100;
    CGPoint center;
    center.x = self.bounds.size.width / 2;
    center.y = self.bounds.size.height / 2;
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
//    [path addLineToPoint:CGPointMake(252, center.y)];
    [path addArcWithCenter:CGPointMake(center.x + 50, center.y) radius:50 startAngle:0 endAngle:M_PI clockwise:NO];

    [path addArcWithCenter:CGPointMake(center.x - 50, center.y) radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    [path1 moveToPoint:CGPointMake(center.x + 50, center.y)];
    [path1 addArcWithCenter:CGPointMake(center.x + 50, center.y) radius:10 startAngle:0 endAngle:M_PI *2 clockwise:YES];

//    [path2 moveToPoint:CGPointMake(center.x - 50, center.y)];
    [path2 addArcWithCenter:CGPointMake(center.x - 50, center.y) radius:10 startAngle:0 endAngle:M_PI *2 clockwise:YES];

    //    [[UIColor orangeColor] setStroke];
    [self.circleColor setStroke];
//    [[UIColor colorWithRed:1 green:0 blue:1 alpha:1] setStroke];
    path.lineWidth = 4;
    [path stroke];
    [path1 fill];

    CGContextSetRGBFillColor(currentContext, 1, 1, 1, 1);
    CGContextAddPath(currentContext, path2.CGPath);
    CGContextFillPath(currentContext);

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];


    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) /100.0;
    float blue = (arc4random() % 100) / 100.0;

    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    self.circleColor = randomColor;


}
-(void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    //手动向其发送setNeedsDisplay消息,
    [self setNeedsDisplay];
}
@end
