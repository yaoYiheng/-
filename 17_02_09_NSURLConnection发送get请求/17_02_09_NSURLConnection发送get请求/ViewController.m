//
//  ViewController.m
//  17_02_09_NSURLConnection发送get请求
//
//  Created by 姚懿恒 on 2017/2/9.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

/**接收到的数据*/
@property (nonatomic, strong) NSMutableData *allData;
@end

@implementation ViewController
- (NSMutableData *)allData{
    if (!_allData) {
        _allData = [NSMutableData data];
    }
    return _allData;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self async];
}

/**
 通过设置代理发送请求.
 */
- (void)requestWithDelegate{
    //1请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=520it&type=JSON"];
    //2创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", request);

    //3. 设置代理.
//    [NSURLConnection connectionWithRequest:request delegate:self];

    //startImmediately 传YES则会马上发送, 如果传NO, 则需要调用start方法.
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [connection start];

}
#pragma mark NSURLConnectionDataDelegate
/**
 //1.当接收到服务器响应的时候调用

 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

}
/**
接收到服务器返回数据的时候调用,调用多次
当接收的数据较大时, 需要对数据进行拼接
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [self.allData appendData:data];
}

/**
 接收完成时, 来到该方法
在该方法中, 解析数据.
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSString *stringFromData = [[NSString alloc] initWithData:self.allData encoding:NSUTF8StringEncoding];

    NSLog(@"%@", stringFromData);
}

/**
 当请求失败的时候调用
*/
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

#pragma mark -----
/**
 发送同步请求
 */
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

/**
 发送异步请求
 */
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
