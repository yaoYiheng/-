//
//  ViewController.m
//  17_02_18_NSURLConnection
//
//  Created by 姚懿恒 on 2017/2/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.

//文件上传步骤
/*
 1.设置请求头
 Content-Type:multipart/form-data; boundary=----WebKitFormBoundaryjv0UfA04ED44AhWx
 2.按照固定的格式拼接请求体的数据

 ------WebKitFormBoundaryjv0UfA04ED44AhWx
 Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
 Content-Type: image/png


 ------WebKitFormBoundaryjv0UfA04ED44AhWx
 Content-Disposition: form-data; name="username"

 123456
 ------WebKitFormBoundaryjv0UfA04ED44AhWx--

 */
//拼接请求体的数据格式
/*
 拼接请求体
 分隔符:----WebKitFormBoundaryjv0UfA04ED44AhWx
 1)文件参数
 --分隔符
 Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
 Content-Type: image/png(MIMEType:大类型/小类型)
 空行
 文件参数
 2)非文件参数
 --分隔符
 Content-Disposition: form-data; name="username"
 空行
 123456
 3)结尾标识
 --分隔符--
*/

#import "ViewController.h"

#define kboundary @"----WebKitFormBoundaryjv0UfA04ED44AhWx"

#define kNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]
@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (void)upload{

    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"POST";

    //4.设置请求头信息
    //Content-Type:multipart/form-data; boundary=----WebKitFormBoundaryjv0UfA04ED44AhWx
    [request setValue:[NSString stringWithFormat:@"Content-Type:multipart/form-data; boundary=%@", kboundary] forHTTPHeaderField:@"Content-Type"];

    //5. 拼接请求体数据
    NSMutableData *dataString = [NSMutableData data];

    /*
     ------WebKitFormBoundaryjv0UfA04ED44AhWx
     Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
     Content-Type: image/png
     */

    [dataString appendData:[[NSString stringWithFormat:@"--%@", kboundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [dataString appendData: kNewLine];

    [dataString appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Snip20160225_341.png\"" dataUsingEncoding:NSUTF8StringEncoding]];

    [dataString appendData:kNewLine];

    [dataString appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];

    //5.2 非文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     123456
     */
    [dataString appendData:[[NSString stringWithFormat:@"--%@",kboundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataString appendData:kNewLine];

    [dataString appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];

    [dataString appendData:kNewLine];
    [dataString appendData:[@"123456" dataUsingEncoding:NSUTF8StringEncoding]];
    [dataString appendData:kNewLine];

    //5.3 结尾标识
    /*
     --分隔符--
     */
    [dataString appendData:[[NSString stringWithFormat:@"--%@--",kboundary] dataUsingEncoding:NSUTF8StringEncoding]];

    //6.设置请求体
    request.HTTPBody = dataString;
    //7. 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {

        //8.解析数据
        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    }];

}
@end
