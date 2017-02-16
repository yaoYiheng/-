//
//  ViewController.m
//  17_02_16_NSURLConnection实现大文件下载
//
//  Created by 姚懿恒 on 2017/2/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 文件大小*/
@property (nonatomic, assign) NSInteger totalFile;
/** 文件路径*/
@property (nonatomic, strong) NSString *fielPath;
/** 当前进度*/
@property (nonatomic, assign) NSInteger currentProgress;

/** 文件句柄*/
@property (nonatomic, strong) NSFileHandle *handle;

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //1. 确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [[NSURLConnection alloc] initWithRequest:request delegate:self];


}
//收到来自服务器的响应时调用.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    //确定文件的总大小.
    self.totalFile = response.expectedContentLength;

    //确定写入路径
    //关于拼接文件名, 可以获取response.suggestedFilename,属性.
    self.fielPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];;



    //通过文件管理者这个类, 创建一个空的文件, 路径为指定路径.
    [[NSFileManager defaultManager] createFileAtPath:self.fielPath contents:nil attributes:nil];

    //创建文件句柄(用于指向文件末尾的指针)
    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fielPath];



}
//接收到来自服务器的数据时调用, 会调用多次.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    //将文件句柄移动到文件末端
    [self.handle seekToEndOfFile];

    //将文件写入到句柄后
    [self.handle writeData:data];

    //设置当前进度
    self.currentProgress += data.length;

    NSLog(@"%f", 1.0 * self.currentProgress / self.totalFile);

    //设置进度条
    self.progressView.progress = 1.0 * self.currentProgress / self.totalFile;


}
//结束传输时调用.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //关闭文件句柄
    [self.handle closeFile];

    self.handle = nil;

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}
@end
