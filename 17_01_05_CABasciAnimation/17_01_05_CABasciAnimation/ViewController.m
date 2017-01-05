//
//  ViewController.m
//  17_01_05_CABasciAnimation
//
//  Created by 姚懿恒 on 2017/1/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *orangeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1. 创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];

//    animation.keyPath = @"hidden";
//    animation.toValue = @YES;

    animation.keyPath = @"backgroundColor";
    animation.toValue = [UIColor redColor];
    animation.keyPath = @"position.y";
    animation.toValue = @400;

    animation.removedOnCompletion = NO;
    animation.fillMode = @"forwards";


    [self.orangeView.layer addAnimation:animation forKey:nil];
}


@end
