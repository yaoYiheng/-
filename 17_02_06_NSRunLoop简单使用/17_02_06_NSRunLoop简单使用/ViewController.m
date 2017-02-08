//
//  ViewController.m
//  17_02_06_NSRunLoop简单使用
//
//  Created by 姚懿恒 on 2017/2/6.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self creatTimerInGCD];
}

/**
 创建GCD中的timer, 相较于NSTimer的定时器,
 优点1: GCD的定时器timer并不会受到runLoop的影响.
 优点2: 绝对精准的.
 */
- (void)creatTimerInGCD{

    // 创建GCD中的定时器

    /*
     敲出
     dispatch_source_t timer -GCD:Dispatch Sourse (Timer)

     第一个参数:source的类型DISPATCH_SOURCE_TYPE_TIMER 表示是定时器
     第二个参数:描述信息,线程ID
     第三个参数:更详细的描述信息
     第四个参数:队列,决定GCD定时器中的任务在哪个线程中执行
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));

   // 设置定时器(起始时间|间隔时间|精准度)
    /*
     第一个参数:定时器对象
     第二个参数:起始时间,DISPATCH_TIME_NOW 从现在开始计时
     第三个参数:间隔时间 2.0 GCD中时间单位为纳秒
     第四个参数:精准度 绝对精准0
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);

    //需要执行的代码
    dispatch_source_set_event_handler(timer, ^{
        [self run];
    });
    //启动定时器
    dispatch_resume(timer);

    //这里需要一个队定时器的强引用, 保证timer在创建后不会被立刻释放.
    self.timer = timer;
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

    //当前模式为默认模式, 当进行UI(scrollView)操作时, 便会停止一切定时器操作.
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
