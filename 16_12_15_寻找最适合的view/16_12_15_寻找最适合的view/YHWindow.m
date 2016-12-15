//
//  YHWindow.m
//  16_12_15_寻找最适合的view
//
//  Created by 姚懿恒 on 2016/12/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHWindow.h"

@implementation YHWindow

/**
 hitTest方法底层实现
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{

    //控件不能与用户交互, 控件隐藏,  控件的透明度小于0.01 的情况下都不能响应事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||self.alpha <= 0.01) {
        return nil;
    }
    //点不在控件身上.
    if ([self pointInside:point withEvent:event] == NO) {
        return nil;
    }

    int count = (int)self.subviews.count;

    //从后往前遍历子控件.
    for (int i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];

        //将点的参照系转换到子控件身上.
        CGPoint childPoint = [self convertPoint:point toView:childView];

        //子控件调用hitTest:方法, 来查询最合适view
        UIView *fitView = [childView hitTest:childPoint withEvent:event];

        //如果能找到, 就返回找到的控件
        if (fitView) {
            return fitView;
        }


    }

    //如果来到这里说明没有找到最合适控件, 自己就是最合适的控件, 并返回.
    return self;

}

@end
