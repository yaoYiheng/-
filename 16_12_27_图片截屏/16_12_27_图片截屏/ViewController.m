//
//  ViewController.m
//  16_12_27_图片截屏
//
//  Created by 姚懿恒 on 2016/12/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//
//MARK:截图代码.

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** cover*/
@property (nonatomic, weak) UIView *coverView;
/** startPoint*/
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation ViewController
#pragma mark 懒加载coverView
- (UIView *)coverView{
    if (!_coverView) {
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor lightGrayColor];
        cover.alpha = 0.6;
        [self.view addSubview:cover];
        _coverView = cover;
    }
    return _coverView;
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {

    //记录当前手指的点
    CGPoint currentPoint = [sender locationInView:self.imageView];

    if (sender.state == UIGestureRecognizerStateBegan) {
        //在手指接触到屏幕的瞬间, 将当前点定为截图的起始点.
        self.startPoint = currentPoint;

    }else if (sender.state == UIGestureRecognizerStateChanged){
        //当手指在屏幕上移动时, 计算出移动面积的大小.

        CGFloat coverX = self.startPoint.x;
        CGFloat coverY = self.startPoint.y;
        CGFloat coverW = currentPoint.x - self.startPoint.x;
        CGFloat coverH = currentPoint.y - self.startPoint.y;

        CGRect coverRect = CGRectMake(coverX, coverY, coverW, coverH);

        //在这里为coverView的大小赋值
        self.coverView.frame = coverRect;

    }else if (sender.state == UIGestureRecognizerStateEnded){
        //当来到该状态时, 意味着手指离开屏幕, 截图的面积大小以确定.


        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
        //获取当前位图上下文
        CGContextRef currentContext = UIGraphicsGetCurrentContext();

        //添加裁剪路径,其大小为之前计算好的覆盖路径
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:self.coverView.frame];
        [clipPath addClip];

        //把当前 imageView(原始图片)的内容绘制到当前位图上下文中.
        [self.imageView.layer renderInContext:currentContext];
        //获取新图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

        //关闭位图上下文
        UIGraphicsEndImageContext();
        //将裁剪的图片传给imageView
        self.imageView.image = newImage;

        //移除cover部分
        [self.coverView removeFromSuperview];

    }

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
