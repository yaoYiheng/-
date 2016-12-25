//
//  UIImage+ImageWithBoarder.h
//  16_12_24_定时器
//
//  Created by 姚懿恒 on 2016/12/26.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithBoarder)

+ (instancetype)imageWithBoarder: (CGFloat)boarder boardColor: (UIColor *)boardColor image:(UIImage *)image;

@end
