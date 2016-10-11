//
//  ViewController.m
//  16_10_10_UIImageView相关练习
//
//  Created by 姚懿恒 on 2016/10/10.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    //设置imageView frame的几种方式
    //方式1
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//
//    imageView.image = [UIImage imageNamed:@"3.jpg"];

    //方式2
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.png"]];
    /*
     UIViewContentModeRedraw,
     
     带有scale， 图片有可能被拉伸或压缩
     UIViewContentModeScaleToFill, //图片完整的被拉伸或压缩到imageView当中, 可能会产生变形
     
     aspect, 比例，缩放是带有比例的
     UIViewContentModeScaleAspectFit,//图片拉伸至完全显示在UIImageView里面为止(图片不会变形)

     UIViewContentModeScaleAspectFill,//图片拉伸至图片的的宽度或者高度等于UIImageView的宽度或者高度为止.看图片的宽高哪一边最接近UIImageView的宽高,一个属性相等后另一个就停止拉伸.

     
     不带scale， 不可能被拉伸或压缩
     UIViewContentModeCenter,
     UIViewContentModeTop,
     UIViewContentModeBottom,
     UIViewContentModeLeft,
     UIViewContentModeRight,
     UIViewContentModeTopLeft,
     UIViewContentModeTopRight,
     UIViewContentModeBottomLeft,
     UIViewContentModeBottomRight,
     */

    //如果想让图片占满整个父容器,并且不变形,可以采用一种折中的方式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    //裁剪掉超出容器范围的内容.
    imageView.clipsToBounds = YES;

    [self.view addSubview:imageView];

    //通过UIToolbar设置毛玻璃效果,
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.view.bounds];

    //设置毛玻璃样式
    //toolBar.barStyle = UIBarStyleBlack;

    //设置毛玻璃的透明度
    toolBar.alpha = 0.7;


    [imageView addSubview:toolBar];
    
}



@end
