//
//  ViewController.m
//  17_02_22_NSURLSession下载大文件
//
//  Created by 姚懿恒 on 2017/2/22.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** <#comments#>*/
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

/** <#comments#>*/
@property (nonatomic, strong) NSData *resumData;

/** <#comments#>*/
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self downloadWithDelegate];

}

/**
 开始下载
 */
- (IBAction)startClick:(id)sender {

    [self downloadWithDelegate];
}

/**
 暂停下载
 */
- (IBAction)pauseClick:(id)sender {
    [self.downloadTask suspend];
}

/**
 继续下载
 */
- (IBAction)continueCLick:(id)sender {

    //如果恢复数据有值, 就继续之前的下载;
    //调用会话对象的downloadTaskWithResumeData:方法断点下载..
    if (self.resumData) {
        [self.session downloadTaskWithResumeData:self.resumData];
    }
    [self.downloadTask resume];
}

/**
 取消下载
 */
- (IBAction)cancelClick:(id)sender {
//    [self.downloadTask cancel];

    //resumeData保存下载文件的相关信息, 但并代表文件数据.
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //将resumeData赋值给属性保存以恢复下载使用.
        self.resumData = resumeData;
    }];
}

/**
 通过代理进行数据下载
 */
- (void)downloadWithDelegate{
    NSURL *url = [NSURL URLWithString:@"http://bizhi.zhuoku.com/2014/01/17/yinhun/yinhun09.jpg"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request];

    [downloadTask resume];

    self.downloadTask = downloadTask;

}
#pragma mark ----------
#pragma mark NSURLSessionDownloadDelegate
/**
 *  当下载完成的时候调用
 *  将文件从临时文件夹移动到到指定文件夹
 *  @param location     文件的临时存储路径
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{

    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];

    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];

    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageWithContentsOfFile:filePath] waitUntilDone:NO];
    NSLog(@"%@", [NSThread currentThread]);
}
/**
 *  当恢复下载的时候调用该方法
 *
 *  @param fileOffset         从什么地方下载
 *  @param expectedTotalBytes 文件的总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{

    NSLog(@"%@", [NSThread currentThread]);
}
/**
 *  写数据时调用该方法
 *
 *  @param session                   会话对象
 *  @param downloadTask              下载任务
 *  @param bytesWritten              本次写入的数据大小
 *  @param totalBytesWritten         下载的数据总大小
 *  @param totalBytesExpectedToWrite  文件的总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{

    NSLog(@"%@, %lld", [NSThread currentThread], bytesWritten);

    self.progressView.progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;

    NSLog(@"%f", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);



}
#pragma mark ----------
#pragma mark downloadWithblcok
/**
 使用block下载文件,
 缺点:不能获取下载进度
 */
- (void)downloadWithblcok{


    NSURL *url = [NSURL URLWithString:@"http://bizhi.zhuoku.com/2014/01/17/yinhun/yinhun09.jpg"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSession *session = [NSURLSession sharedSession];


    /**
     该方法会返回一个NSURLSessionDownloadTask对象, 该方法已经完成了写入沙盒的操作.
     并将文件保存在(tmp)文件夹中


     第一个参数:请求对象
     第二个参数:completionHandler 回调
     location:
     response:响应头信息
     error:错误信息
     */
    //该方法内部已经实现了边接受数据边写沙盒(tmp)的操作
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        //拼接文件路径
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];

        //使用NSFileManager对象完成 下载后的文件由临时文件夹移动到指定文件夹的操作
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];

        NSLog(@"%@-----%@",[NSThread currentThread], filePath);

        //由于该block在子线程中进行, 所以需要回到主线程中刷新UI
        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageWithContentsOfFile:filePath] waitUntilDone:NO];
    }];
     //开始下载
    [downloadTask resume];
}


@end
