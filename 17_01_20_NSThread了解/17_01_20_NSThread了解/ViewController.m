//
//  ViewController.m
//  17_01_20_NSThread了解
//
//  Created by 姚懿恒 on 2017/1/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

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
    for (int i = 0 ; i < 100000; i++) {
        NSLog(@"%d---%@", i, [NSThread mainThread]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
