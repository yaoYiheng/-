//
//  ViewController.m
//  17_03_09_通知中心在多线程中的使用


/*
    知识点:
          通知顺序:一定要先监听,在发出
          bug:监听不到通知,马上想到有可能先发出通知,在监听通知
        
        在 子线程 中监听, 在 主线程 中发送通知 -> receiveMessage方法会在 主线程 中调用
        在 主线程 中监听, 在 子线程 中发送通知 -> receiveMessage方法会在 子线程 中调用
        结论:方法会在哪个线程中调用, 取决于通知是在哪条线程中发出的.


 */
//  Created by 姚懿恒 on 2017/3/9.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#define kMessage @"sendingMessage"

@interface ViewController ()
/** 观察者*/
@property (nonatomic, weak) id observer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //当view加载完毕时, 添加观察者,

    //监听通知方法一:

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage) name:kMessage object:nil];

    //监听通知方法二:
    /*
     参数一:通知的名称
     参数二:发送通知的对象, 传nil代表匿名通知
     参数三:队列, 决定接下来的block在哪个线程中调用, 如果传nil:则会在发布通知的线程中执行
     参数四:监听到通知的发送, 就会调用block 中的方法.
     
     //该方法有返回值, 需要拿到该对象后在控制器销毁时,移除观察者
     */
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:kMessage object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        [self receiveMessage];
    }];
}

/**
 点击屏幕时, 发送消息
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [[NSNotificationCenter defaultCenter] postNotificationName:kMessage object:nil];

    //在子线程中发送消息.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kMessage object:nil];
    });

}

- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];

    //移除观察者对象
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}
- (void)receiveMessage{
    NSLog(@"在%@线程中接收到消息", [NSThread currentThread]);

    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"%@", [NSThread currentThread]);
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
