//
//  ViewController.m
//  17_02_20_04_NSURLSession的基本使用
//
//  Created by 姚懿恒 on 2017/2/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self postWithNSURLSession];
}
#pragma mark ----------
#pragma mark 发送get请求
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
