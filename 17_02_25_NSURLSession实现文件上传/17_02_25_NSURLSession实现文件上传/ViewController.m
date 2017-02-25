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

@end
