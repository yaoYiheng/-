//
//  YHLogInViewController.m
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHLogInViewController.h"
#import "MBProgressHUD+XMG.h"
#import "YHContactTableViewController.h"

@interface YHLogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation YHLogInViewController


#pragma mark 点击登录按钮跳转到联系人界面.
- (IBAction)logInButtonClick:(UIButton *)sender {
    [MBProgressHUD showMessage:@"努力加载中.."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if ([self.accountTextField.text isEqualToString:@"yyh"] && [self.passwordTextField.text isEqualToString:@"123"])
        {
            YHContactTableViewController *contactViewController = [[YHContactTableViewController alloc] init];

            contactViewController.userName = self.accountTextField.text;

            [self.view endEditing:YES];
            [self.navigationController pushViewController:contactViewController animated:YES];
        }
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.accountTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self textChanged];
}
- (void)textChanged{
    self.logInButton.enabled = self.accountTextField.text.length && self.passwordTextField.text.length;
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
