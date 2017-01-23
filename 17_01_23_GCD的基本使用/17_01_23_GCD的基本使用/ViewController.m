//
//  ViewController.m
//  17_01_23_GCD的基本使用
//
//  Created by 姚懿恒 on 2017/1/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self asyncConcurrent];

}
//异步函数(dispatch_async) + 并发队列(DISPATCH_QUEUE_CONCURRENT):会开启多条线程,队列中的任务是并发执行
-(void)asyncConcurrent{
    //1. 创建队列
    /**
     调用该函数创建一个并发队列.
     第一个参数传入一个字符串, 作为标识.
     第二个参数 可传   DISPATCH_QUEUE_CONCURRENT  并发
                    DISPATCH_QUEUE_SERIAL      串行
     */
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_CONCURRENT);

    //2. 调用异步函数,dispatch_async()
    /**
     参数一: 之前创建的队列
     参数二: 需要执行的方法(封装任务)
     */
    dispatch_async(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });


    /**
     
     2017-01-23 20:28:33.270 17_01_23_GCD的基本使用[26439:1280510] task1----<NSThread: 0x600000265300>{number = 3, name = (null)}
     2017-01-23 20:28:33.270 17_01_23_GCD的基本使用[26439:1280512] task3----<NSThread: 0x608000263bc0>{number = 5, name = (null)}
     2017-01-23 20:28:33.270 17_01_23_GCD的基本使用[26439:1280509] task2----<NSThread: 0x6080002643c0>{number = 4, name = (null)}
     
     */
}
//异步函数(dispatch_async)+串行队列(DISPATCH_QUEUE_SERIAL):会开线程,开一条线程,队列中的任务是串行执行的
-(void)asyncSerial{
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });


    /**
     
     2017-01-23 20:27:54.791 17_01_23_GCD的基本使用[26417:1279777] task1----<NSThread: 0x60800007fcc0>{number = 3, name = (null)}
     2017-01-23 20:27:54.791 17_01_23_GCD的基本使用[26417:1279777] task2----<NSThread: 0x60800007fcc0>{number = 3, name = (null)}
     2017-01-23 20:27:54.791 17_01_23_GCD的基本使用[26417:1279777] task3----<NSThread: 0x60800007fcc0>{number = 3, name = (null)}
     */
}

//同步函数(dispatch_sync)+并发队列(DISPATCH_QUEUE_CONCURRENT):不会开线程,任务是串行执行的
-(void)syncConcurrent{
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });
}

//同步函数(dispatch_sync)+串行队列(DISPATCH_QUEUE_SERIAL):不会开线程,任务是串行执行的
-(void)syncSerial{
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });
}
@end
