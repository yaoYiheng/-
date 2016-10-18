//
//  UIImage+YHExtention.m
//  16_10_12_按钮相关
//
//  Created by 姚懿恒 on 2016/10/18.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "UIImage+YHExtention.h"

@implementation UIImage (YHExtention)
+(instancetype)resezableImageWithImageNage:(NSString *)imageName{

    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;

    return [image stretchableImageWithLeftCapWidth:imageWidth * 0.5 topCapHeight:imageHeight * 0.5];
}

@end
