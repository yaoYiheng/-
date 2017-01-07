//
//  ViewController.m
//  17_01_07_转盘
//
//  Created by 姚懿恒 on 2017/1/7.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHYRoundAbout.h"
@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, weak) YHYRoundAbout *roundAbout;

@end

@implementation ViewController
- (IBAction)startRotate:(UIButton *)sender {
    [self.roundAbout startRotate];
}
- (IBAction)pause:(UIButton *)sender {
    [self.roundAbout pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    YHYRoundAbout *roundAbout = [YHYRoundAbout roundAbout];
    roundAbout.center = self.view.center;
    [self.view addSubview:roundAbout];
    self.roundAbout = roundAbout;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
