//
//  YYHPopViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/13.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHPopViewController.h"
#import "YYHBuyButton.h"

@interface YYHPopViewController ()

/** 弹出的菜单*/
@property (nonatomic, weak) UIButton *menuButton;
@end

@implementation YYHPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [YYHBuyButton buttonWithType:UIButtonTypeCustom];

    [button setTitle:@"全部彩种" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
    [button sizeToFit];
    self.menuButton = button;
    
    self.navigationItem.titleView = button;
    
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [self.menuButton setTitle:@"全部彩种全部彩种全部彩种" forState:UIControlStateNormal];
//    [self.menuButton setImage:nil forState:UIControlStateNormal];
//}
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
