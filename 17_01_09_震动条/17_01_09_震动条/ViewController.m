//
//  ViewController.m
//  17_01_09_震动条
//
//  Created by 姚懿恒 on 2017/1/9.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test];
//    [self test2];


}
#pragma mark -倒影效果
- (void)configureShadow{

    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.view.layer;

    repL.instanceCount = 2;

    repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    //更改复制层RGB值, 是颜色变淡, 其修改器透明度, 实现影子效果
    repL.instanceRedOffset -=0.2;
    repL.instanceBlueOffset -= 0.2;
    repL.instanceGreenOffset -= 0.2;
    repL.instanceAlphaOffset -= 0.2;
}
#pragma mark -知乎等待效果
- (void)test{

    //创建复制层
    CAReplicatorLayer *relL = [CAReplicatorLayer layer];
    relL.frame = CGRectMake(100, 200, 50, 50);
    [self.view.layer addSublayer:relL];

    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 10, 10);
    layer.cornerRadius = 5;
    layer.masksToBounds = YES;
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [relL addSublayer:layer];


    relL.instanceDelay = 0.1;
    relL.instanceCount = 20;
//    relL.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
//    animation.keyPath =@"alpha";
//    animation.keyPath = @"transform.scale.y";
    animation.values  = @[@0,@1];
    animation.duration = 0.4;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;

    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-30, -30, 60 , 60)];
    animation1.keyPath = @"position";
    animation1.path = path.CGPath;
    animation1.duration = 2;
    //    animation.autoreverses = YES;
    animation1.repeatCount = MAXFLOAT;

    [layer addAnimation:animation1 forKey:nil];
    [layer addAnimation:animation forKey:nil];

}
- (void)test2{

    CAReplicatorLayer *relL = [CAReplicatorLayer layer];
    relL.frame = CGRectMake(100, 400, 50, 50);
    [self.view.layer addSublayer:relL];


    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 20, 20);
    layer.cornerRadius = 10;
    layer.masksToBounds = YES;
    layer.backgroundColor = [UIColor grayColor].CGColor;
    [relL addSublayer:layer];


    relL.instanceDelay = 0.2;
    relL.instanceCount = 5;
//    relL.instanceTransform = CATransform3DMakeTranslation(20, 0, 0);

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];

    CGPoint center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 30 , 30)];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:center];
//    [path addLineToPoint:CGPointMake(20, 20)];
//    [path addLineToPoint:CGPointMake(370, 500)];
    animation.keyPath = @"position";
    animation.path = path.CGPath;
    animation.duration = 1;
//    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;

    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    //    animation.keyPath = @"transform.scale.y";
    animation1.values  = @[@0.2];
    animation1.duration = 0.4;
    animation1.autoreverses = YES;
    animation1.repeatCount = MAXFLOAT;
    [layer addAnimation:animation1 forKey:nil];


    [layer addAnimation:animation forKey:nil];

}

#pragma mark -添加复制层动画.
- (void)configureReplicatorLayer
{

    //创建复制层.
    CAReplicatorLayer *relL = [CAReplicatorLayer layer];
    relL.frame = CGRectMake(50, 50, 300, 300);
    relL.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:relL];

    //设置需要做动画效果的图层, 并将其添加到复制层
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 30, 150);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 1);
    layer.position = CGPointMake(0, relL.frame.size.height);
    [relL addSublayer:layer];

    //复制层动画延迟
    relL.instanceDelay = 0.3;
    //复制包括自己在内的图层数
    relL.instanceCount = 5;
    //对每个复制的图层进行位移.
    relL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);

    //创建基本动画, 设置相关属性并将其添加到动画层
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale.y";
    animation.toValue = @0;
    animation.duration = 1;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;

    [layer addAnimation:animation forKey:nil];




}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
