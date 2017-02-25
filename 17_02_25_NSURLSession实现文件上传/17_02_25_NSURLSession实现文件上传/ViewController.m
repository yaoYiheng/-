//
//  ViewController.m
//  17_02_25_NSURLSession实现文件上传
//
//  Created by 姚懿恒 on 2017/2/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#define Kboundary @"----WebKitFormBoundaryjv0UfA04ED44AhWx"

#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

@interface ViewController ()<NSURLSessionDataDelegate>

/** <#comments#>*/
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ViewController

/**
 当上传数据时, 通过该方法监听数据上传.

 @param session 会话对象
 @param task 任务对象
 @param bytesSent 本次发送数据大小
 @param totalBytesSent 已发送数据大小
 @param totalBytesExpectedToSend 总数据大小
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{

}
- (NSURLSession *)session{
    if (!_session) {

        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

        configuration.allowsCellularAccess = YES;
        configuration.timeoutIntervalForRequest = 10;
        configuration.timeoutIntervalForResource = 10;

        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (void)upload1{
    //1.url
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];

    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    //2.1 设置请求方法
    request.HTTPMethod = @"POST";

    //2.2 设请求头信息
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",Kboundary] forHTTPHeaderField:@"Content-Type"];

    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:[self getData] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

    }];

    [uploadTask resume];
}

- (NSData *)getData{
    NSMutableData *fileData = [NSMutableData data];
    //5.1 文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
     Content-Type: image/png(MIMEType:大类型/小类型)
     空行
     文件参数
     */
    [fileData appendData:[[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];

    //name:file 服务器规定的参数
    //filename:Snip20160225_341.png 文件保存到服务器上面的名称
    //Content-Type:文件的类型
    [fileData appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Sss.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:KNewLine];

    UIImage *image = [UIImage imageNamed:@"Snip20160226_90"];
    //UIImage --->NSData
    NSData *imageData = UIImagePNGRepresentation(image);
    [fileData appendData:imageData];
    [fileData appendData:KNewLine];

    //5.2 非文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     123456
     */
    [fileData appendData:[[NSString stringWithFormat:@"--%@",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:KNewLine];
    [fileData appendData:[@"123456" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];

    //5.3 结尾标识
    /*
     --分隔符--
     */
    [fileData appendData:[[NSString stringWithFormat:@"--%@--",Kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return fileData;


}
@end
