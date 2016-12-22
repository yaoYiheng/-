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

}
#pragma mark  画变色半圆
- (void)drawHalfCircle{
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat radius = 100;
    CGPoint center;
    center.x = self.bounds.size.width / 2;
    center.y = self.bounds.size.height / 2;
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(252, center.y)];


    //    [[UIColor orangeColor] setStroke];
    [self.circleColor setFill];
    path.lineWidth = 4;
    [path fill];

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
