//
//  ViewController.m
//  16_12_13_Transform的使用
//
//  Created by 姚懿恒 on 2016/12/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController
- (IBAction)moveUp:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{

        //CGAffineTransformMakeTranslation该方法只会在原来的基础上进行一次移动操作.
//        self.imageView.transform = CGAffineTransformMakeTranslation(0, 100);

        //若想在移动后的基础上再进行移动, 需要调用如下方法.
        self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, 50);
    }];
}
- (IBAction)moveLeft:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{

        //CGAffineTransformMakeTranslation该方法只会在原来的基础上进行一次移动操作.
        //        self.imageView.transform = CGAffineTransformMakeTranslation(0, 100);

        //若想在移动后的基础上再进行移动, 需要调用如下方法.
        self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 50, 50);
    }];
}
- (IBAction)rotate:(UIButton *)sender {

    //这里传入的参数是弧度, 而不是角度.
    [UIView animateWithDuration:0.5 animations:^{

        //其中有Make的方法, 都只能在原基础上进行一次操作.
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI_4);

        //想着原基础上进行多次操作, 调用不含有Make的方法(需要把自身传进去)
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_4);
    }];
}
- (IBAction)scale:(UIButton *)sender {

    [UIView animateWithDuration:0.5 animations:^{
        //原基础上只进行一次缩放
        self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);


    }];
}

-(IBAction)startAuto{
    //该方法会返回一个自动执行的定时器对象.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];


    //如果不加以下代码, 在执行别的操作时, 定时器便会停止自动加载, 为解决这个问题采用以下代码
    /*
     NSDefaultRunLoopMode(默认):同一时间只能执行一个任务
     NSRunLoopCommonModes(公用):可分配一定的时间执行其他任务
     */
    //修改timer在runLoop中的模式为NSRunLoopCommonModes
    //目的:无论主线程在做什么操作, 都会分配一定时间处理定时器.
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (IBAction)stop {
    [self.timer invalidate];
}


- (void)test{
    [UIView animateWithDuration:1 animations:^{
        //原基础上只进行一次缩放
        self.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);

        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, 2.0, 2.0);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
