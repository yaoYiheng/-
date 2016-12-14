//
//  test.m
//  16_12_13_Transform的使用
//
//  Created by 姚懿恒 on 2016/12/14.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "test.h"

@implementation test

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];

    CGFloat offsetX = currentPoint.x - previousPoint.x;
    CGFloat offsetY = currentPoint.y - previousPoint.y;
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

@end
