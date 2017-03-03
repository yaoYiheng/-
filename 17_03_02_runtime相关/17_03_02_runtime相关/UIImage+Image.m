//
//  UIImage+Image.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/3.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/message.h>

@implementation UIImage (Image)

/**
 该方法只加载一次, 在代码加载进内场时调用
 */
+ (void)load{

    //获取系统imageNamed方法, 从类中获取类方法.
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));


    //获取需要交换的另一个方法
    Method yh_imageNamedMethod = class_getClassMethod(self, @selector(yh_imageNamed:));

    //调用该方法获取实例方法.
//    Method is = class_getInstanceMethod(self, @selector(init));

    /*
     调用该方法, 实现方法的交换.
     在调用方法1时, 实现方法2,反之亦然
     */
    method_exchangeImplementations(imageNamedMethod, yh_imageNamedMethod);

}

+ (instancetype)yh_imageNamed:(NSString *)name{

//    UIImage *image = [UIImage imageNamed:name];
    //在方法交换后, 调用imageNamed:, 实际上是调用yh_imageNamed:
    //当外界调用imageNamed时, 这两个方法会相互调用, 形成死循环.
    //所以这里应该调用

    UIImage *image = [UIImage yh_imageNamed:name];

    if (image) {
        NSLog(@"加载成功");
    }
    else{
        NSLog(@"加载失败");
    }
    return image;

}

@end
