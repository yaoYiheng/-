//
//  ViewController.m
//  16_12_24_定时器
//
//  Created by 姚懿恒 on 2016/12/24.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //0. 加载图片
    UIImage *originalImage = [UIImage imageNamed:@"Image009"];
    //1. 获取位图上下文
    UIGraphicsBeginImageContextWithOptions(originalImage.size, YES, 0.0);
    //2. 将图片绘制到上下文中
    [originalImage drawAtPoint:CGPointZero];

    //3. 设置想要显示的文字, 以及设置文字的相关属性, 通过字典的形式.
    NSString *logo = @"By Yiheng";
    NSMutableDictionary *logoAttribute = [NSMutableDictionary dictionary];
    logoAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    logoAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //4. 将文字绘制到上下文中
    [logo drawAtPoint:CGPointZero withAttributes:logoAttribute];

    //5. 调用UIGraphicsGetImageFromCurrentImageContext()返回一张已经生成图片与水印的新图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    self.imageView.image = newImage;

    //6. 由于是手动获取位图上下文, 需要在结束后关闭图形上下文
    UIGraphicsEndImageContext();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
