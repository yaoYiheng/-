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
#pragma mark 实现截屏功能.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //0. 开启一个位图上下文, 与view一样大小
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);

    //1. 获取当前开启的上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    //2. 必须使用渲染模式, 才能将UIView的内容渲染到上下文当中
    [self.view.layer renderInContext:currentContext];

    //3. 从当前的上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    //4. 关闭图形上下文.
    UIGraphicsEndImageContext();

    //5. 将生成的图片写入到桌面 (调用UIImageJPEGRepresentation)将生成JPG图形文件转化为NSData对象
    //该方法的第二个参数, 取值范围为0-1,为1质量最高.
    NSData *imageData = UIImageJPEGRepresentation(newImage, 1);

    //调用该方法生成图片格式为png.
    NSData *imageData1 = UIImagePNGRepresentation(newImage);

    //将NSData对象保存至指定路径.
    [imageData writeToFile:@"/Users/Morris/Desktop/newImage1.jpg" atomically:YES];
    [imageData1 writeToFile:@"/Users/Morris/Desktop/newImage1.png" atomically:YES];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
