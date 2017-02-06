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
    //主线程对应的runloop
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
//    NSLog(@"%@", mainRunLoop);
    //当前线程对应的runLoop
    NSRunLoop *currentLoop = [NSRunLoop currentRunLoop];
//    NSLog(@"%@", currentLoop);
    NSLog(@"main == %p, current == %p", mainRunLoop, currentLoop);

    //core foundatation获得方法.
    CFRunLoopRef mainRL = CFRunLoopGetMain();
    CFRunLoopRef currentRL = CFRunLoopGetCurrent();

    NSLog(@"main == %p, current == %p", mainRL, currentRL);
}

@end
