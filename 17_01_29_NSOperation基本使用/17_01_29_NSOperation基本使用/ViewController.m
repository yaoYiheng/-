//
//  ViewController.m
//  17_01_29_NSOperation基本使用
//
//  Created by 姚懿恒 on 2017/1/29.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
}

- (void)inovationOperation{
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];

    [op1 start];
}
- (void)print{
    NSLog(@"%@---%s---%d",[NSThread currentThread], __func__, __LINE__);
}
@end
