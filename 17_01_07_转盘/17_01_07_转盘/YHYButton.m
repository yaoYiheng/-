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

@end
