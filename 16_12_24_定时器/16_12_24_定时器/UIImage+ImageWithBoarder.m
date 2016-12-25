//
//  UIImage+ImageWithBoarder.m
//  16_12_24_定时器
//
//  Created by 姚懿恒 on 2016/12/26.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "UIImage+ImageWithBoarder.h"

@implementation UIImage (ImageWithBoarder)

#pragma mark 为裁剪图片添加边框
+ (instancetype)imageWithBoarder: (CGFloat)boarder boardColor: (UIColor *)boardColor image:(UIImage *)image{

    //设置一个 在图片的基础上添加的一个边框大小的 Size;
    CGSize boardSize = CGSizeMake(image.size.width + 2 * boarder, image.size.height + 2 *boarder);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(boardSize, NO, 0.0);

    //绘制图片后的背景
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, boardSize.width, boardSize.height)];
    [boardColor set];
    [path fill];

    //添加裁剪路径, 起点为边框大小.
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(boarder, boarder, image.size.width, image.size.height)];
    [clipPath addClip];

    //把图片绘制到上下文中
    [image drawAtPoint:CGPointMake(boarder, boarder)];

    //获取新图片需要在关闭图形上下文之前, 否则不会返回图片.
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    //关闭图形上下文
    UIGraphicsEndImageContext();

    //返回生成的图片
    return newImage;


}

@end
