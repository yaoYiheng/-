//
//  ViewController.m
//  17_02_15_多值参数和中文输出
//
//  Created by 姚懿恒 on 2017/2/15.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/weather?place=Beijing&place=Guangzhou&place=Shanghai"];


    //2. 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3. 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {

        if (connectionError) return;

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        NSLog(@"%@", dict);
    }];
}

@end
