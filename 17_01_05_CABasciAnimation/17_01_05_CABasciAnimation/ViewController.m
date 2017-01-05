//
//  ViewController.m
//  17_01_05_CABasciAnimation
//
//  Created by 姚懿恒 on 2017/1/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

#define angleToRadio(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ginImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ginImageView.layer.borderWidth = 8;
    self.ginImageView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.ginImageView.layer.cornerRadius = 100;

    self.ginImageView.layer.masksToBounds = YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1. 创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];

//    animation.keyPath = @"hidden";
////    animation.toValue = @YES;
//
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = [UIColor redColor];
//    animation.keyPath = @"position.y";
//    animation.toValue = @400;
//
        //动画完成是是否移除动画
//    animation.removedOnCompletion = NO;
        //完成后动画保持什么状态
//    animation.fillMode = @"forwards";
//
//      将动画添加到需要实现动画的层
//    [self.orangeView.layer addAnimation:animation forKey:nil];

    /**
     通过修改transform.scale, 实现心跳效果
     */
    animation.keyPath = @"transform.scale";
    animation.toValue = @(0.5);

    //动画执行时长
    animation.duration = 1;
    //动画重复次数
    animation.repeatCount = MAXFLOAT;
    //怎么去怎么样回
    animation.autoreverses = YES;
    [self.heartImageView.layer addAnimation:animation forKey:nil];

    /**
    以下为帧动画 CAKeyframeAnimation
     

     用法1:可以传入多个动画效果值.
             KFAnimation.values = @[@angleToRadio(180), @angleToRadio(-180)];


     用法2:控件设置运行路径
            1. 创建动画对象
            2. 设置动画属性
         KFAnimation.keyPath = @"position"; (位置改变)
            3. 为控件添加移动路径
         UIBezierPath *path = [UIBezierPath bezierPath];
         [path moveToPoint:center];
         [path addLineToPoint:CGPointMake(0, 0)];

         KFAnimation.path = path.CGPath;
     
     
     注意: 想要为同一个控件添加多个动画, 比如旋转的同时进行移动, 需要创建两个动画对象, 并
     添加到需要设置动画的子控件上.

     */

    CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animation];
    //设置动画属性
    KFAnimation.keyPath = @"position";


    CGPoint center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);


    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addLineToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(370, 500)];

    KFAnimation.path = path.CGPath;


    KFAnimation.duration = 4;
    KFAnimation.autoreverses = YES;
    KFAnimation.repeatCount = MAXFLOAT;

    [self.ginImageView.layer addAnimation:KFAnimation forKey:nil];




    //旋转动画
    CAKeyframeAnimation *KFAnimation1 = [CAKeyframeAnimation animation];
    KFAnimation1.keyPath = @"transform.rotation";



    /**
     #define angleToRadio(angle) ((angle) / 180.0 * M_PI)

     翻转效果,将一个空间进行180°旋转后在进行-180°旋转,

     也可以设置控件抖动效果.
     
     */

    KFAnimation1.values = @[@angleToRadio(180), @angleToRadio(-180)];

    KFAnimation1.duration = 5;
    KFAnimation1.repeatCount = MAXFLOAT;

    [self.ginImageView.layer addAnimation:KFAnimation1 forKey:nil];



}


@end
