//
//  ViewController.m
//  16_12_24_模仿系统UIImageView
//
//  Created by 姚懿恒 on 2016/12/24.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YHImageView *imageView = [[YHImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:imageView];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
