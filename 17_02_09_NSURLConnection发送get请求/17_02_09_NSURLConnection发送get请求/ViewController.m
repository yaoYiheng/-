//
//  ViewController.m
//  17_02_09_NSURLConnection发送get请求
//
//  Created by 姚懿恒 on 2017/2/9.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self async];
}
- (void)sync{
    //1请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=520it&type=JSON"];
    //2创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", request);

    //3.发送请求
    //真实类型:NSHTTPURLResponse
    NSHTTPURLResponse *response = nil;


     /*
     第一个参数:请求对象
     第二个参数:响应头信息
     第三个参数:错误信息
     返回值:响应体

    //该方法是阻塞的,即如果该方法没有执行完则后面的代码将得不到执行
     该方法从9.0后就废弃, 而且该方法会阻塞线程, 该方法不执行完, 就不会继续执行后面的代码

     */
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];

    //解析数据 
    NSString *stringFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSLog(@"%@", stringFromData);

}

- (void)async{

    //1请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=520it&type=JSON"];
    //2创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", request);

    /*
     第一个参数:请求对象
     第二个参数:队列 决定代码块completionHandler的调用线程
     第三个参数:completionHandler 当请求完成(成功|失败)的时候回调
     response:响应头
     data:响应体
     connectionError:错误信息
     */
    //向服务器发送异步请求, 并接收服务器的响应.
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {


        NSString *stringFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        NSLog(@"%@", stringFromData);
    }];
}


@end
