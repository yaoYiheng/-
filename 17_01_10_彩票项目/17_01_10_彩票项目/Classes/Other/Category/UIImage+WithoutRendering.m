//
//  UIImage+WithoutRendering.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIImage+WithoutRendering.h"

@implementation UIImage (WithoutRendering)

#pragma mark -返回一张没有渲染的图片
+(UIImage *)imageWithoutRendering:(NSString *)imageName{

    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
