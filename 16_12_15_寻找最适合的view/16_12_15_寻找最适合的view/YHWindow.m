//
//  YHWindow.m
//  16_12_15_寻找最适合的view
//
//  Created by 姚懿恒 on 2016/12/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHWindow.h"

@implementation YHWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    UIView *fitView = [super hitTest:point withEvent:event];
    NSLog(@"%s, %@",__func__, fitView);
    return fitView;
}

@end
