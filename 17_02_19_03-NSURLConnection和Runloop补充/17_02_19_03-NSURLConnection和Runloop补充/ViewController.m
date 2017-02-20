//
//  ViewController.m
//  17_02_19_03-NSURLConnection和Runloop补充
//
//  Created by 姚懿恒 on 2017/2/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self newThreadDelegate1];
}


/**
    设置代理, 并发送请求.
 */
- (void)delegate1{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"]];

    //设置代理
    //代理方法:默认是在主线程中调用的
    NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:self];

    //设置代理方法在哪个线程中调用, 不能设置主队列.
    [connect setDelegateQueue:[[NSOperationQueue alloc] init]];

    NSLog(@"%d", __LINE__);
}

- (void)delegate2{

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"]];

    //设置代理
    //代理方法:默认是在主线程中调用的
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];;

    //设置代理方法在哪个线程中调用
    [connect setDelegateQueue:[[NSOperationQueue alloc] init]];

    //开始发送请求
    [connect start];

    NSLog(@"%d", __LINE__);

}

/**
 开启子线程, 发送请求
 由于是在子线程中, 默认runLoop不会开启, 需要手动开启.
 */
- (void)newThreadDelegate1{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"]];
        //设置代理
        //代理方法:默认是在主线程中调用的
        NSURLConnection *connect = [NSURLConnection connectionWithRequest:request delegate:self];

        //设置代理方法在哪个线程中调用, 不能设置主队列.
        [connect setDelegateQueue:[[NSOperationQueue alloc] init]];

        [[NSRunLoop currentRunLoop] run];

        NSLog(@"%@----%d", [NSThread currentThread], __LINE__);
        
    });
    
}


/**
 该方法对比newThreadDelegate1, 并没开启子线程对应的runLoop, 但是依然能够执行
 原因在于如果当前的runloop没有开启,那么[connect start];该方法内部会自动获得当前线程对应的runloop对象并且开启
 */
- (void)newThreadDelegate2{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"]];

        //设置代理
        //代理方法:默认是在主线程中调用的
        NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];;

        //设置代理方法在哪个线程中调用
        [connect setDelegateQueue:[[NSOperationQueue alloc] init]];

        //开始发送请求
        [connect start];


        
        NSLog(@"%d", __LINE__);
    });


}
#pragma mark ----------
#pragma mark NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"=====%@======", [NSThread currentThread]);
}
@end
