//
//  ViewController.m
//  16_10_12_按钮相关
//
//  Created by 姚懿恒 on 2016/10/12.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(40, 40, 100, 100);
    [button1 setImage:[UIImage imageNamed:@"player_btn_pause_highlight@2x"] forState:UIControlStateNormal];

    [button1 setBackgroundImage:[UIImage imageNamed:@"buttongreen.png"] forState:UIControlStateNormal];

    [button1 setImage:[UIImage imageNamed:@"m1.png"] forState:UIControlStateHighlighted];

    [self.view addSubview:button1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
