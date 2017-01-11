
//
//  YYHCover.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHCover.h"

#define YYHKeyWindow [UIApplication sharedApplication].keyWindow

@implementation YYHCover


/**
 1.蒙版一般添加在keyWidow上面
 2.pop菜单加载keyWidown上面,如果添加到蒙版上面,会随着父控件的透明而透明
 3.解决不透明的方法,不要修改alpha,修改背景颜色就可以了
 */
+ (void)show{
    UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];

    [YYHKeyWindow addSubview:cover];
}

@end
