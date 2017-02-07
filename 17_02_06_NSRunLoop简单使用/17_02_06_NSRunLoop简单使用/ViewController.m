//
//  ViewController.m
//  17_02_06_NSRunLoop简单使用
//
//  Created by 姚懿恒 on 2017/2/6.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self timer];
}


-(void)timer2
{
    NSRunLoop *currentRunloop = [NSRunLoop currentRunLoop];

    //该方法内部自动添加到runloop中,并且设置运行模式为默认
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];

    //开启runloop
    [currentRunloop run];
}

-(void)run
{
    NSLog(@"run-----%@---%@",[NSThread currentThread],[NSRunLoop currentRunLoop].currentMode);
}


- (void)timer{
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];

    //当前模式为默认模式, 当进行UI操作时, 便会停止一切定时器操作.
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    //界面追踪模式, 当UI界面有操作时, 才会执行相关任务
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];


    //    NSRunLoopCommonModes = NSDefaultRunLoopMode + UITrackingRunLoopMode
    /*
     凡是添加到NSRunLoopCommonModes中的事件爱你都会被同时添加到打上commmon标签的运行模式上

     0 : <CFString 0x10af41270 [0x10a0457b0]>{contents = "UITrackingRunLoopMode"}
     2 : <CFString 0x10a065b60 [0x10a0457b0]>{contents = "kCFRunLoopDefaultMode"
     */
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)getRunloop{
    //主线程对应的runloop
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    //    NSLog(@"%@", mainRunLoop);
    //当前线程对应的runLoop
    NSRunLoop *currentLoop = [NSRunLoop currentRunLoop];
    //    NSLog(@"%@", currentLoop);
    NSLog(@"main == %p, current == %p", mainRunLoop.getCFRunLoop, currentLoop.getCFRunLoop);

    //core foundatation获得方法.
    CFRunLoopRef mainRL = CFRunLoopGetMain();
    CFRunLoopRef currentRL = CFRunLoopGetCurrent();

    NSLog(@"main == %p, current == %p", mainRL, currentRL);

    //Runloop和线程的关系
    //一一对应,主线程的runloop已经创建,但是子线程的需要手动创建
    [[[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil] start];


}

@end
