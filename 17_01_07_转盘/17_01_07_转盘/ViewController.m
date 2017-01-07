//
//  ViewController.m
//  17_01_07_转盘
//
//  Created by 姚懿恒 on 2017/1/7.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHYRoundAbout.h"
@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, weak) YHYRoundAbout *roundAbout;

@end

@implementation ViewController

#pragma mark -开始以及停止旋转
/**
 转盘的旋转及停止功能应该被封装到其内部, 控制器并不需要了解其如何实现, 只需要在外界调用
 其提供的方法即可.

 */
- (IBAction)startRotate:(UIButton *)sender {
    [self.roundAbout startRotate];
}
- (IBAction)pause:(UIButton *)sender {
    [self.roundAbout pause];
}

#pragma mark -lifecycle of view
- (void)viewDidLoad {
    [super viewDidLoad];

    //创建一个YHYRoundAbout 并添加到控制器view的重点
    YHYRoundAbout *roundAbout = [YHYRoundAbout roundAbout];
    roundAbout.center = self.view.center;
    [self.view addSubview:roundAbout];
    //为成员变量赋值
    self.roundAbout = roundAbout;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
