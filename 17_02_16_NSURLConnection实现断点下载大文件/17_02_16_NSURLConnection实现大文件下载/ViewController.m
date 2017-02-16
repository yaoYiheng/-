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

/** <#comments#>*/
@property (nonatomic, strong) NSURLConnection *connection;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)startDown:(id)sender {
    [self down];
}
- (IBAction)cancelDown:(id)sender {
    [self.connection cancel];
}

- (IBAction)goOn:(id)sender {
    [self down];
}


@end
