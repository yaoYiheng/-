//
//  YHYButton.m
//  17_01_07_转盘
//
//  Created by 姚懿恒 on 2017/1/7.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YHYButton.h"

@implementation YHYButton


/**
 重写该方法, 屏蔽掉系统当按钮点击时出现高亮的状态.
只是实现, 不调用父类方法
 */
- (void)setHighlighted:(BOOL)highlighted{
//    [super setHighlighted:highlighted];
}

/**
 重写该方法, 返回自定义按钮中图片的位置以及宽高


 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 40;
    CGFloat imageH = 50;
    CGFloat imageY = 20;
    CGFloat imageX = (contentRect.size.width - imageW) / 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

#pragma mark -解决按钮重叠问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //设置可点击区域
    CGRect enableRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2);
    //判断点是否落在rect上
    if (CGRectContainsPoint(enableRect, point)) {
        return [super hitTest:point withEvent:event];
    }
    else{
        return nil;
    }
}
@end
