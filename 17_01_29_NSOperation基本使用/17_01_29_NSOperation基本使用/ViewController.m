//
//  ViewController.m
//  17_01_29_NSOperation基本使用
//
//  Created by 姚懿恒 on 2017/1/29.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YYHOperation.h"

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (IBAction)start:(id)sender {
    [self test1];
}
- (IBAction)pause:(id)sender {

    /*
     队列中的任务也是有状态的:已经执行完毕的 | 正在执行 | 排队等待状态
     */
    //不能暂停当前正在处于执行状态的任务
    [self.queue setSuspended:YES];
}
- (IBAction)goON:(id)sender {
    //可以从暂停的状态中恢复
    [self.queue setSuspended:NO];
}
- (IBAction)cancel:(id)sender {
    [self.queue cancelAllOperations];
}
- (void)test1{
    self.queue = [[NSOperationQueue alloc] init];
    YYHOperation *op1 = [[YYHOperation alloc] init];
    [self.queue addOperation:op1];
}

- (void)test{
    self.queue = [[NSOperationQueue alloc] init];

    //maxConcurrentOperationCount 同一时间最多有多少个任务可以执行
    //串行执行任务!=只开一条线程 (线程同步)
    // maxConcurrentOperationCount >1 那么就是并发队列
    // maxConcurrentOperationCount == 1 那就是串行队列
    // maxConcurrentOperationCount == 0  不会执行任务
    // maxConcurrentOperationCount == -1 特殊意义 最大值 表示不受限制
    self.queue.maxConcurrentOperationCount = 1;

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"op1%@, %d,",[NSThread currentThread], i);
        }
    }];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"op2%@, %d,",[NSThread currentThread], i);
        }
    }];

    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"op3%@, %d,",[NSThread currentThread], i);
        }
    }];

    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"op4%@, %d,",[NSThread currentThread], i);
        }
    }];

    [self.queue addOperation:op1];

    [self.queue addOperation:op2];
    [self.queue addOperation:op3];
    [self.queue addOperation:op4];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self inovationOperation];

//    [self blockOperation];

//    [self inovationOperationWithQueue];

//    [self blockOperationWithQueue];

    [self customOperation];

}
- (void)customOperation{
    //1. 创建操作
    YYHOperation *op1 = [[YYHOperation alloc] init];
    YYHOperation *op2 = [[YYHOperation alloc] init];

    //2. 创建非主队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    //3. 添加操作到队列
    [queue addOperation:op1];
    [queue addOperation:op2];



}
- (void)blockOperationWithQueue{

    //1. 创建操作, 封装任务
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
    
    //2. 创建队列, 添加操作到队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];

    //简便方法
    //在队列中添加待执行任务
    [queue addOperationWithBlock:^{
        NSLog(@"%@----%d", [NSThread currentThread], __LINE__);
    }];


}
- (void)inovationOperationWithQueue{
    //1.创建操作,封装任务
    /*
     第一个参数:目标对象 self
     第二个参数:调用方法的名称
     第三个参数:前面方法需要接受的参数 nil
     */
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];

    //2.创建队列

    /*
     GCD:
     串行类型:create & 主队列
     并发类型:create & 全局并发队列
     NSOperation:
     主队列:   [NSOperationQueue mainQueue] 和GCD中的主队列一样,串行队列
     非主队列: [[NSOperationQueue alloc]init]  非常特殊(同时具备并发和串行的功能)
     //默认情况下,非主队列是并发队列
     */

    //在主队列中执行, 串行执行
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    //执行结果
    /**
     2017-01-29 11:04:50.094 17_01_29_NSOperation基本使用[41441:1950481] <NSThread: 0x608000261100>{number = 1, name = main}----[ViewController print]---98
     2017-01-29 11:04:50.094 17_01_29_NSOperation基本使用[41441:1950481] <NSThread: 0x608000261100>{number = 1, name = main}----[ViewController print]---98
     2017-01-29 11:04:50.095 17_01_29_NSOperation基本使用[41441:1950481] <NSThread: 0x608000261100>{number = 1, name = main}----[ViewController print]---98
     */

    //会开启子线程, 并发执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //执行结果
    /**
     2017-01-29 11:10:03.679 17_01_29_NSOperation基本使用[41533:1954263] <NSThread: 0x600000074380>{number = 3, name = (null)}----[ViewController print]---117
     2017-01-29 11:10:03.679 17_01_29_NSOperation基本使用[41533:1954265] <NSThread: 0x6080000718c0>{number = 4, name = (null)}----[ViewController print]---117
     2017-01-29 11:10:03.679 17_01_29_NSOperation基本使用[41533:1954262] <NSThread: 0x60000006ca80>{number = 5, name = (null)}----[ViewController print]---117
     */

    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];


}
- (void)blockOperation{
    //1. 创建操作
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
