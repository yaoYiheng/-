//
//  ViewController.m
//  17_01_20_NSThread了解
//
//  Created by 姚懿恒 on 2017/1/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

/**
 注意点:凡是和UI相关的操作都需要放到主线程中去处理
 不要将耗时的任务放到主线程中进行, 因为主线程主要处理UI事件, 耗时的
 任务会阻塞主线程, 不能及时处理UI事件, 给人以卡的感觉.
 */
//    for (int i = 0 ; i < 100000; i++) {
//        NSLog(@"%d---%@", i, [NSThread mainThread]);
//    }


#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取主线程
    NSThread *mainThreadA = [NSThread mainThread];
    //获取当前线程
    NSThread *currentThreadB = [NSThread currentThread];
    //判断是否为主线程
    //number == 1 是主线程
    BOOL isMain = [NSThread isMainThread];

    BOOL isMainB = [currentThreadB isMainThread];

    NSLog(@"%@, %@, %zd", mainThreadA, currentThreadB, isMain);
}
- (IBAction)btnClick:(id)sender {


    [self ctreatNSThreadA];


}

/**
 alloc init 创建主线程, 需手动开始主线程
 */
- (void)ctreatNSThreadA{
    NSThread *threadA = [[NSThread alloc] initWithTarget:self selector:@selector(task) object:nil];
    [threadA start];

    //设置线层名
//    threadA.name = @"线程A";
//    //设置优先级  取值范围 0.0 ~ 1.0 之间 最高是1.0 默认优先级是0.5
//    threadA.threadPriority = 1.0;
//
//    NSThread *threadB = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    [threadB start];
//    threadB.name = @"线程B";
//    threadB.threadPriority = 0.1;
//
//    NSThread *threadC = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
//    [threadC start];
//    threadC.name = @"线程C";
//    threadC.threadPriority = 0.5;
}

- (void)task{
    for (int i = 0; i < 10; i++) {
        NSLog(@"%d", i);
    }
    //阻塞线程方法1.
    [NSThread sleepForTimeInterval:2];

    //阻塞线程方法2.
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];

    for (int i = 0; i < 10; i++) {
        NSLog(@"%d",i);
        if (i == 5) {
            //强制退出线程
            [NSThread exit];
        }
    }
}
/**
 分离一条子线程, 自动启动
 */
- (void)creatThreadB{
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];


}


/**
 开启隐式线程, 注意调用的是控制器的方法, 而不是NSThread
 */
- (void)creatThreadC{
    [self performSelectorInBackground:@selector(run) withObject:nil];
}
- (void)creatPthread{
    //1.创建线程对象
    pthread_t threadA;

    //2.创建线程
    /**
     pthread_creat
     参数一: 第一步创建的线程对象的地址
     参数二: 线程的而一些属性
     参数三: 创建的线程需要执行的方法
     参数四: 函数需要接受的参数
     */
    pthread_create(&threadA, NULL, sum, NULL);

    //创建第二条线线程
    pthread_t threadB;

    pthread_create(&threadB, NULL, sum, NULL);


    //判断两条线程是否是同一线程
    int value = pthread_equal(threadA, threadB);

    NSLog(@"value === %d", value);

}


void *sum(void *pa){
    NSLog(@"=====%@", [NSThread currentThread]);

    /**
     将耗时的操作放到子线程中, 不影响UI操作.无卡顿感.
     
     */
        for (int i = 0 ; i < 100; i++) {
            NSLog(@"%d---%@", i, [NSThread mainThread]);
        }
    return NULL;
}

- (void)run{

    for (NSInteger i = 0; i<100; i++) {
        NSLog(@"%zd----%@",i,[NSThread currentThread].name);
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
