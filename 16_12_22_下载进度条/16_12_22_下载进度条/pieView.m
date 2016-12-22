//
//  pieView.m
//  16_12_22_下载进度条
//
//  Created by 姚懿恒 on 2016/12/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "pieView.h"

@implementation pieView

- (void)drawRect:(CGRect)rect{
    NSArray *array = @[@10, @5, @20, @12, @13, @10, @25,  @5];

    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.width / 2);
    CGFloat radius = rect.size.width / 2 - 10;
    CGFloat startAngle = 0;
    CGFloat angle = 0;
    CGFloat endAngle = 0;

    //遍历数组中的每个元素, 然后求出所占饼图面积的百分比, 进行绘制.
    //每次绘制完, 上一次的终止角度等于下一次的起始角度.

    for (NSNumber *number in array) {
        startAngle = endAngle;
        angle = number.intValue / 100.0 * M_PI * 2;
        endAngle = startAngle + angle;

        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        //添加一条到中点的线
        [path addLineToPoint:center];

        //生成随机染色
        [[self randomColor] set];

        [path fill];
    }
}
- (UIColor *)randomColor{
    CGFloat red = arc4random_uniform(256) / 256.0;
    CGFloat green = arc4random_uniform(256) / 256.0;
    CGFloat blue = arc4random_uniform(256) / 256.0;

    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];

    [self setNeedsDisplay];
}
@end
