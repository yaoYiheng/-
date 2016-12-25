//
//  ViewController.m
//  16_12_24_定时器
//
//  Created by 姚懿恒 on 2016/12/24.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageWithBoarder.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageWithBoarder:20 boardColor:[UIColor orangeColor] image:[UIImage imageNamed:@"Gin_1.jpeg"]];


}

- (void)drawImageWithCircle{
    //0. 加载图片
    UIImage *originalImage = [UIImage imageNamed:@"Gin_1.jpeg"];
    //1. 获取位图上下文
    //上下文的大小和原始图片保持一样,以免图片被拉伸缩放.
    //opaque:不透明度,当为YES为不透明, 为NO的时候透明,
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);

    /**
     实现裁剪效果, 需要先设置裁剪区域, 在进行图片以及水印的绘制, 才能实现裁剪的效果.
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    //添加路径为裁剪区域.
    [path addClip];

    //2. 将图片绘制到上下文中
    [originalImage drawAtPoint:CGPointZero];

    //3. 设置想要显示的文字, 以及设置文字的相关属性, 通过字典的形式.
    //    NSString *logo = @"By Yiheng";
    //    NSMutableDictionary *logoAttribute = [NSMutableDictionary dictionary];
    //    logoAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    //    logoAttribute[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //    //4. 将文字绘制到上下文中
    //    [logo drawAtPoint:CGPointMake(300, 700) withAttributes:logoAttribute];


    //5. 调用UIGraphicsGetImageFromCurrentImageContext()返回一张已经生成图片与水印的新图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    //6. 由于是手动获取位图上下文, 需要在结束后关闭图形上下文
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImage;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
