//
//  ViewController.m
//  16_10_23_AutoScrollView的封装
//
//  Created by 姚懿恒 on 2016/10/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHAutoScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YHAutoScrollView *autoScrollView = [YHAutoScrollView autoScrollView];
    autoScrollView.imageNames = @[@"1", @"2", @"3", @"4"];
    autoScrollView.frame = CGRectMake(20, 30, 300, 200);

//    autoScrollView.center = self.view.center;
    [self.view addSubview:autoScrollView];

}




@end
