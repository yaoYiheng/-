//
//  ViewController.m
//  17_02_17_输出流下载
//
//  Created by 姚懿恒 on 2017/2/17.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
- (IBAction)start:(id)sender {
    [self downLoad];
}
- (IBAction)cancel:(id)sender {
}
- (IBAction)goingOn:(id)sender {
    [self downLoad];
}

- (void)downLoad{
    NSURL *url = [NSURL URLWithString:@""]

}


@end
