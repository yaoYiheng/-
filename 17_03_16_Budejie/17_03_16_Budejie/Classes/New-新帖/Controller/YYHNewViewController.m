//
//  YYHNewViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNewViewController.h"
#import "YYHSubscribeController.h"

@interface YYHNewViewController ()

@end

@implementation YYHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"MainTagSubIcon"] hightligtedImage:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(tagClick)];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

}


/**
点击时, 跳转到订阅页面
 */
- (void)tagClick{
    YYHSubscribeController *subVC = [[YYHSubscribeController alloc] init];
    [self.navigationController pushViewController:subVC animated:YES];


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
