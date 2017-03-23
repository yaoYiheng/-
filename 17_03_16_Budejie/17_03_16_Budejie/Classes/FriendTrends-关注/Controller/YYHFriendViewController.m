//
//  YYHFriendViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHFriendViewController.h"
#import "YYHLogNRegisterViewController.h"

@interface YYHFriendViewController ()

@end

@implementation YYHFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] hightligtedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] Target:self action:@selector(test)];

    self.navigationItem.title = @"我的关注";
}

/**
 点击按钮时, 以modal效果弹出注册登录界面
 */
- (IBAction)loginButtonClick {
    YYHLogNRegisterViewController *logVC = [[YYHLogNRegisterViewController alloc] init];

    [self presentViewController:logVC animated:YES completion:nil];
    

}

- (void)test{
    NSLog(@"关注");
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
