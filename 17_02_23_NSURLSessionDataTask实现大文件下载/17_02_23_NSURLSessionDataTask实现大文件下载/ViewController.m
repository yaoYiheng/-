//
//  ViewController.m
//  17_02_23_NSURLSessionDataTask实现大文件下载
//
//  Created by 姚懿恒 on 2017/2/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>

/** 文件总大小*/
@property (nonatomic, assign) NSUInteger totalSize;
/** 当前大小*/
@property (nonatomic, assign) NSUInteger currentSize;
/** 文件路径*/
@property (nonatomic, strong) NSString *filePath;

/** <#comments#>*/
@property (nonatomic, strong) NSFileHandle *handler;
@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self downloadWithDataTask];
}
- (void)downloadWithDataTask{
    //1.url
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];

    [dataTask resume];
}
#pragma mark ----------
#pragma mark NSURLSessionDataDelegate

/**
 收到服务器的相应会来到该方法, 默认会取消该请求, 需要在第四个参数中设置回调实现具体功能

 @param session 会话对象
 @param dataTask 请求任务对象
 @param response 响应头信息
 @param completionHandler 回调 传给系统
 
 可以在该方法中获取到请求文件的大小, 以及设置文件的保存路径
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    //获取文件大小
    self.totalSize = response.expectedContentLength;

    //设置文件保存路径
    self.filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[response suggestedFilename]];

    //通过文件管理者创建一个空文件夹用来保存文件
    [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];

    //创建一个文件句柄
    self.handler = [NSFileHandle fileHandleForWritingAtPath:self.filePath];

    //设置回调

    /*
     NSURLSessionResponseCancel = 0,取消 默认
     NSURLSessionResponseAllow = 1, 接收
     NSURLSessionResponseBecomeDownload = 2, 变成下载任务
     NSURLSessionResponseBecomeStream        变成流
     */
    completionHandler(NSURLSessionResponseAllow);


}

/**
 接收到来自服务器的数据时会来到该方法, 多次调用
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    //操作文件句柄写文件
    [self.handler seekToEndOfFile];

    [self.handler writeData:data];

    self.currentSize += data.length;
    NSLog(@"%lu", (unsigned long)self.currentSize);

}
/**
 *  请求结束或者是失败的时候调用
 *
 *  @param session           会话对象
 *  @param task          请求任务
 *  @param error             错误信息
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{

    NSLog(@"%@", self.filePath);
    [self.handler closeFile];
    self.handler = nil;

}

@end
