//
//  UIImage+YHImage.m
//  16_10_12_按钮相关
//
//  Created by 姚懿恒 on 2016/10/18.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "UIImage+YHImage.h"

@implementation UIImage (YHImage)

+(instancetype)resezableImageWithImageNage:(NSString *)imageName{
//    UIImage *image = [UIImage imageNamed:imageName];
//
//    CGFloat imageWidth = image.size.width;
//    CGFloat imageHeigh = image.size.height;
//
//    return [image stretchableImageWithLeftCapWidth:imageWidth * 0.5 topCapHeight:imageHeigh * 0.5];
    UIImage *image = [UIImage imageNamed:imageName];

    // 获取图片的尺寸
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeiht = image.size.height;

    // 返回一张拉伸且受保护的图片
    return [image stretchableImageWithLeftCapWidth:imageWidth * 0.5 topCapHeight:imageHeiht * 0.5 ];
}
@end
