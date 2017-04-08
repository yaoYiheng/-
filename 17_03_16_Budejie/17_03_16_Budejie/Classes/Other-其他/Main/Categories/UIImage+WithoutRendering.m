//
//  UIImage+WithoutRendering.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIImage+WithoutRendering.h"

@implementation UIImage (WithoutRendering)

#pragma mark 返回不经过渲染的图片
+ (UIImage *)imageWithoutRendering:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithStretched:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];

}

- (instancetype)yyh_circleImage{
    //1. 开启图形上下文

    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);

    //2. 绘制路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];

    //3. 添加路径
    [path addClip];

    //画图
    [self drawAtPoint:CGPointZero];

    //4. 返回新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();


    return image;

}
+ (instancetype)yyh_circleImageNamed:(NSString *)name{

    return [[UIImage imageNamed:name] yyh_circleImage];
}
@end
