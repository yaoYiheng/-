//
//  ViewController.m
//  17_02_19_03-NSURLConnection和Runloop补充
//
//  Created by 姚懿恒 on 2017/2/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self newThreadDelegate1];
}


@end
