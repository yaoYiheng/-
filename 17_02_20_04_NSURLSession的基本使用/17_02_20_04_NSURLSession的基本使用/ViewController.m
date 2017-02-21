//
//  ViewController.m
//  17_02_20_04_NSURLSession的基本使用
//
//  Created by 姚懿恒 on 2017/2/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>

/** <#comments#>*/
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self postWithNSURLSession];
}

#pragma mark ----------
#pragma mark lazy loading
- (NSMutableData *)data{
    if (!_data) {
        _data = [NSMutableData  data];
    }

    return _data;
}
#pragma mark ----------
#pragma mark 设置NSURLSession代理方法

- (void)NSURLSessionWithDelegate{

    //1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3. 创建NSURLSession对象
    NSURLSession *sesstion = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *dataTask = [sesstion dataTaskWithRequest:request];

    [dataTask resume];
}


/**
 当接收到来自服务器的的响应时调用
 默认取消请求, 需要在该方法中的第四个参数设置参数以更改

 @param session 会话对象
 @param dataTask 请求任务
 @param response 请求体
 @param completionHandler 回调
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{

    /*
     NSURLSessionResponseCancel = 0,取消 默认
     NSURLSessionResponseAllow = 1, 接收
     NSURLSessionResponseBecomeDownload = 2, 变成下载任务
     NSURLSessionResponseBecomeStream        变成流
     */
    completionHandler(NSURLSessionResponseAllow);

}

/**
 接收到来自服务器的数据时调用, 该方法会多次调用.

 @param session 会话对象
 @param dataTask 请求任务对象
 @param data 数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{

    [self.data appendData:data];
}

/**

 @param session 会话对象
 @param task 请求任务对象
 @param error 错误信息
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{

}
#pragma mark ----------
#pragma mark NSURLSession发送get请求
- (void)getWithNSURLSession{
    //1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3. 创建NSURLSession对象
    NSURLSession *sesstion = [NSURLSession sharedSession];

    //4. 创建请求对象
    NSURLSessionDataTask *dataTask = [sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //5. 解析数据
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];

    [dataTask resume];

}

/**
 如果发送的是get请求, 可以调用
 - (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;
 省略设置请求对象的步骤
 */
- (void)getWithNSURLSession2{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];

    [dataTask resume];
}

#pragma mark ----------
#pragma mark 发送POST请求
/**
 发送POST请求.

 */
- (void)postWithNSURLSession{

    //1. 确定url
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];

    //2. 创建请求, 设置请求体,请求头
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"POST";

    request.HTTPBody = [@"username=123&pwd=123&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];

    //3. 创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];


    /*
     第一个参数:请求对象
     第二个参数:completionHandler 当请求完成之后调用 !!! 在子线程中调用,如果当请求完数据后
     需要进行刷新UI等需要在主线程中完成的任务, 需要进行线程间的通信.
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];

    [dataTask resume];


}

@end
