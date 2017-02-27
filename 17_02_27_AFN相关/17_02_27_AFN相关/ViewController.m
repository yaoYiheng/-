//
//  ViewController.m
//  17_02_27_AFN相关
//
//  Created by 姚懿恒 on 2017/2/27.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

//http://120.25.226.186:32812/login?username=123&pwd=122&type=JSON


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self downloadWithAFN];
}

/**
 使用AFN发送get请求时, 不需要像NSURLSession一样设置url与request,
 而是首先创建会话管理者, 然后调用管理者的GET:...方法, 在方法中传入相关
 的参数来发送GET请求
 */
- (void)getWithAFN{
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSDictionary *parameters = @{
                                 @"username":@"520it",
                                 @"pwd":@"520it",
                                 @"type":@"JSON"};

    //@"http://120.25.226.186:32812/login"


    //2.发送GET请求
    /*
     第一个参数:请求路径(不包含参数).NSString
     第二个参数:字典(发送给服务器的数据~参数)
     第三个参数:progress 进度回调
     第四个参数:success 成功回调
     task:请求任务
     responseObject:响应体信息(JSON--->OC对象)
     第五个参数:failure 失败回调
     error:错误信息
     响应头:task.response
     */
    NSURLSessionDataTask *dataTask = [manager GET:@"http://120.25.226.186:32812/login" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject class]);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];

    //3. 发送请求
    [dataTask resume];
}

/**
 使用AFN发送POST请求, 与发送GET请求基本一致, 只是在调用方法时, 选择[manager POST...];

 */
- (void)postWithAFN{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSDictionary *parameters = @{
                                 @"username":@"520it",
                                 @"pwd":@"520it",
                                 @"type":@"JSON"};


    /*
     第一个参数:请求路径(不包含参数).NSString
     第二个参数:字典(发送给服务器的数据~参数)
     第三个参数:progress 进度回调
     第四个参数:success 成功回调
     task:请求任务
     responseObject:响应体信息(JSON--->OC对象)
     第五个参数:failure 失败回调
     error:错误信息
     响应头:task.response
     */
   NSURLSessionDataTask *dataTask =  [manager POST:@"http://120.25.226.186:32812/login" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"%@---%@",[responseObject class],responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];

    [dataTask resume];

}
- (void)downloadWithAFN{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]];

    /*
     第一个参数：请求对象
     第二个参数：进度回调
     downloadProgress：下载进度
     第三个参数：destination 目标位置回调
     targetPath 文件的临时存放路径 （该方法内部完成了边接收数据边写入数据到沙盒的操作）
     response：响应头信息
     返回值：该block块需要接收一个NSURL类型的返回值（在该返回值中告诉AFN文件的目标位置内部会自动完成文件的剪切操作）
     第四个参数：completionHandler 请求结束后的回调
     response：响应头信息
     filePath：文件的目标位置==destination block的返回值
     */
  NSURLSessionDownloadTask *downloadTask =  [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress)
    {

        /*
         downloadProgress:
            completedUnitCount表示已下载数据
            totalUnitCount表示总数据
         */
        NSLog(@"%f", 1.0* downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response)
    {
        /*
         在该block中需要返回一个文件路径的URL作为保存文件的路径.
         */
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];

        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error)
    {
        NSLog(@"%@", filePath);
    }];

    [downloadTask resume];
}
- (void)uploadWithAFN{

}


@end
