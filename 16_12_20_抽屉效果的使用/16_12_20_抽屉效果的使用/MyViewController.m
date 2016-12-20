//
//  MyViewController.m
//  16_12_20_抽屉效果的使用
//
//  Created by 姚懿恒 on 2016/12/20.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "MyViewController.h"
#import "TableViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //当一个控制器(A)的view被添加到另一个控制器(B)的view中时, 也应该将控制器A添加为控制器B的子控制器.
    TableViewController *tableViewController = [[TableViewController alloc] init];
    tableViewController.view.frame = self.redView.frame;
    tableViewController.tableView.rowHeight = 100;
    [self.redView addSubview:tableViewController.view];
    //将tableViewController添加为当前控制器的子控制器
    [self addChildViewController:tableViewController];

    TableViewController *GreentableViewController = [[TableViewController alloc] init];
    GreentableViewController.view.frame = self.redView.frame;
    GreentableViewController.view.backgroundColor = [UIColor greenColor];
    [self.greenView addSubview:GreentableViewController.view];
    [self addChildViewController:GreentableViewController];

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
