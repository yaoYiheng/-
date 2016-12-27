//
//  ViewController.m
//  16_12_28_图片擦除- -
//
//  Created by 姚懿恒 on 2016/12/28.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFront;

@end

@implementation ViewController

- (IBAction)panGes:(UIPanGestureRecognizer *)sender {
    /**
     利用两张图片, 清除上面的那一张显示下面的一张实现擦除效果.
     主要实现方法:

     清除选中的部分
     CGContextClearRect(currentContext, removeArea);

     */
    CGPoint currentPoint = [sender locationInView:self.imageViewFront];

    //通过手指移动坐标计算擦除大小及位置
    CGFloat removeWh = 30;
    CGFloat removeX = currentPoint.x - removeWh / 2;
    CGFloat removeY = currentPoint.y - removeWh / 2;
    CGRect removeArea = CGRectMake(removeX, removeY , removeWh, removeWh);

    UIGraphicsBeginImageContextWithOptions(self.imageViewFront.frame.size, NO, 0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //将当前imageView上显示地图片渲染到图形上下文中.
    [self.imageViewFront.layer renderInContext:currentContext];
    //清除选中的部分
    CGContextClearRect(currentContext, removeArea);
    //获取新图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭
    UIGraphicsEndImageContext();
    self.imageViewFront.image = newImage;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
