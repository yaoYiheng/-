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
//



}


@end
