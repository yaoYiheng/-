//
//  ViewController.m
//  17_02_17_输出流下载
//
//  Created by 姚懿恒 on 2017/2/17.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** <#comments#>*/
@property (nonatomic, strong) NSURLConnection *connection;

/** <#comments#>*/
@property (nonatomic, assign) NSInteger totalFile;

/** <#comments#>*/
@property (nonatomic, assign) NSInteger currentFile;

/** <#comments#>*/
@property (nonatomic, strong) NSString *filePath;
/** <#comments#>*/
@property (nonatomic, strong) NSOutputStream *stream;
@end

@implementation ViewController
- (IBAction)start:(id)sender {
    [self downLoad];
}
- (IBAction)cancel:(id)sender {
    [self.connection cancel];
}
- (IBAction)goingOn:(id)sender {
    [self downLoad];
}

- (void)downLoad{
    NSURL *url = [NSURL URLWithString:@"http://pic.hanhande.com/files/121010/1283568_172701_4988.jpg"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];


    NSString *range = [NSString stringWithFormat:@"btyes=%ld-",self.currentFile];

    [request setValue:range forHTTPHeaderField:@"Range"];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    self.connection = connection;


}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    self.totalFile = response.expectedContentLength + self.currentFile;

    if (self.currentFile > 0) {
        return;
    }

    self.filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];


    //创建下载流对象, 不需要使用文件管理者来事先创建一个新文件
    /*
     第一个参数:文件的路径
     第二个参数:YES 追加
     特点:如果该输出流指向的地址没有文件,那么会自动创建一个空的文件
     */
    NSOutputStream *stream = [[NSOutputStream alloc] initToFileAtPath:self.filePath append:YES];

    //要想使用输出流, 需要打开.
    [stream open];

    self.stream = stream;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    //输出流该方法, 写入文件
    [self.stream write:data.bytes maxLength:data.length];

    self.currentFile += data.length;

    self.progressView.progress = (double)self.currentFile / self.totalFile;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    //文件下载完毕后, 需要关闭下载流, 清理指针.
    [self.stream close];
    self.stream = nil;


    self.imageView.image = [UIImage imageWithContentsOfFile:self.filePath];
}
@end
