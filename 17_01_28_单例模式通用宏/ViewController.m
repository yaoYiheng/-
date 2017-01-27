//
//  ViewController.m
//  17_01_27_ARC环境下实现单例模式
//
//  Created by 姚懿恒 on 2017/1/27.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YYHTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    YYHTool *tool1 = [YYHTool shareTool];
    YYHTool *tool2 = [[YYHTool alloc] init];
    YYHTool *tool3 = [YYHTool new];
    NSLog(@"%p, %p, %p", tool1, tool2, tool3);
}

@end
