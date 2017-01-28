//
//  ViewController.m
//  17_01_29_NSOperation基本使用
//
//  Created by 姚懿恒 on 2017/1/29.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self inovationOperation];

//    [self blockOperation];

}
- (void)blockOperation{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self print];
    }];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self print];
    }];

    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self print];
    }];



    //追加任务
    //注意:如果一个操作中的任务数量大于1,那么会开子线程并发执行任务
    //注意:不一定是子线程,有可能是主线程

    [op3 addExecutionBlock:^{
        [self print];
    }];

    [op3 addExecutionBlock:^{
        [self print];
    }];
    [op3 addExecutionBlock:^{
        [self print];
    }];

    //注意: 追加任务需在开始之前追加.
    [op1 start];
    [op2 start];
    [op3 start];
}

/**
 inovationOperation 在主线程, 串行执行任务
 */
- (void)inovationOperation{
    //1.创建操作,封装任务
    /*
     第一个参数:目标对象 self
     第二个参数:调用方法的名称
     第三个参数:前面方法需要接受的参数 nil
     */
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];

    //2.启动|执行操作
    [op1 start];
}
- (void)print{
    NSLog(@"%@---%s---%d",[NSThread currentThread], __func__, __LINE__);
}
@end
