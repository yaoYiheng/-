//
//  ViewController.m
//  17_02_24_NSURLSessionDataTask离线下载
//
//  Created by 姚懿恒 on 2017/2/24.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/** 文件总大小*/
@property (nonatomic, assign) NSUInteger totalSize;

/** <#comments#>*/
@property (nonatomic, assign) NSUInteger currentSize;

/** <#comments#>*/
@property (nonatomic, strong) NSString *filePath;
/** <#comments#>*/
@property (nonatomic, strong) NSFileHandle *handle;
/** <#comments#>*/
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
/** <#comments#>*/
@property (nonatomic, strong) NSURLSession *session;



@end

@implementation ViewController
- (NSUInteger)getFileInfo{
    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:self.filePath error:nil];

    NSUInteger fileSize = [fileDict[@"NSFileSize"] integerValue];
    return fileSize;
}

#pragma mark ----------
#pragma mark lazy loading
- (NSString *)filePath{
    if (_filePath == nil) {
        _filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
    }
    return _filePath;
}
- (NSURLSessionDataTask *)dataTask{
    if (_dataTask == nil) {
        //1. 确定URL
        //    NSURL *url = [NSURL URLWithString:@"http://www.windows7en.com/uploads/140829/2009120309142160.jpg"];

        NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];

        //想要实现离线下载, 需要设置请求头
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

        /*
         当点击取消时,dataTask的取消是不可以恢复的, 想要恢复下载, 
         思路:重新发送数据请求, 请求位置从已下载的文件处获取.

         
         */
        self.currentSize = [self getFileInfo];
        NSString *range = [NSString stringWithFormat:@"bytes=%ld-", self.currentSize];
        [request setValue:range forHTTPHeaderField:@"Range"];

        _dataTask = [self.session dataTaskWithRequest:request];
    }
    return _dataTask;

}
- (NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
#pragma mark ----------
#pragma mark 点击按钮调用
- (IBAction)startClick:(id)sender {
    NSLog(@"开始");
    [self.dataTask resume];
}
- (IBAction)cancelClick:(id)sender {
    NSLog(@"取消----");
    [self.dataTask cancel];
    /*
     点击取消按钮后, 清空dataTask指针.
     作用在于, 当下次点击开始或继续时, 会进行判断, 如果该指针为空, 
     则会重新设置下载任务, 并从已下载的未完成文件处继续下载
     */

    self.dataTask = nil;
}


- (IBAction)goOnClick:(id)sender {
    NSLog(@"继续----");
    [self.dataTask resume];
}
- (IBAction)pauseClick:(id)sender {
    NSLog(@"暂停----");
    [self.dataTask suspend];
}

#pragma mark ----------
#pragma mark NSURLSessionDataDelegate


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    //获取文件大小
    self.totalSize = response.expectedContentLength + self.currentSize;

    //拼接文件路径

    //创建空文件
    /*
     当当前已下载数据为0时, 才重新创建新文件
     */
    if(self.currentSize == 0){
        [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];
    }

    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];

    //移动句柄到文件末尾
    [self.handle seekToEndOfFile];

    //设置系统回调
    completionHandler(NSURLSessionResponseAllow);



}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{

    //拼接数据
    [self.handle writeData:data];

    self.currentSize += data.length;

    self.progressView.progress = 1.0 * self.currentSize/ self.totalSize;

    NSLog(@"%f",1.0 * self.currentSize/ self.totalSize);


}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"%@", self.filePath);

    [self.handle closeFile];

    self.handle = nil;


}

/**
 当会话任务结束后, 需要清理会话对象, 不然会造成内存泄漏.
 */
- (void)dealloc{

    [self.session invalidateAndCancel];
}
@end
