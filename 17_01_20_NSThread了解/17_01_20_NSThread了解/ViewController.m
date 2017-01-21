//
//  ViewController.m
//  17_01_20_NSThread了解
//
//  Created by 姚懿恒 on 2017/1/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

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

    /**
     注意点:凡是和UI相关的操作都需要放到主线程中去处理
     不要将耗时的任务放到主线程中进行, 因为主线程主要处理UI事件, 耗时的
     任务会阻塞主线程, 不能及时处理UI事件, 给人以卡的感觉.
     */
//    for (int i = 0 ; i < 100000; i++) {
//        NSLog(@"%d---%@", i, [NSThread mainThread]);
//    }



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
        for (int i = 0 ; i < 100000; i++) {
            NSLog(@"%d---%@", i, [NSThread mainThread]);
        }
    return NULL;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
