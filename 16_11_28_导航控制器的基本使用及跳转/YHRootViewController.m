//
//  YHRootViewController.m
//  16_11_28_导航控制器的基本使用及跳转
//
//  Created by 姚懿恒 on 2016/11/28.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHRootViewController.h"
#import "YHViewControllerOne.h"

@interface YHRootViewController ()

@end

@implementation YHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUp];
}

- (void)setUp{
    UIButton *jump = [UIButton buttonWithType:UIButtonTypeContactAdd];
    jump.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 50, 50);

    [jump addTarget:self action:@selector(jumpToNext) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:jump];
}
- (void)jumpToNext{
    YHViewControllerOne *oneViewController = [[YHViewControllerOne alloc] init];
   [self.navigationController pushViewController:oneViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
