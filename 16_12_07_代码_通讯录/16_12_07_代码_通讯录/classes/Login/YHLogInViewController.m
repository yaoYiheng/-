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

#define YHAccount @"account"
#define YHPassword @"pasaword"
#define IsRemember @"isRemember"
#define IsAutoLogIn @"isAutoLogin"

@interface YHLogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogInSwith;

@end

@implementation YHLogInViewController


/**
 当记住密码选项关闭时, 也就不能实现自动登录.
 */
- (IBAction)rememberPassword:(UISwitch *)sender {
    if (sender.on == NO) {
        [self.autoLogInSwith setOn:NO animated:YES];
    }
}

/**
 当自动登录选中时, 必须记住密码.

 */
- (IBAction)autoLogIn:(UISwitch *)sender {
    if (sender.on == YES) {
        [self.rememberSwitch setOn:YES animated:YES];
    }
}
#pragma mark 点击登录按钮跳转到联系人界面.
- (IBAction)logInButtonClick:(UIButton *)sender {
    //第三方框架, 显示加载时的动画以及需要显示的文字
    [MBProgressHUD showMessage:@"努力加载中.."];

    //模拟网络延迟, 设置0.2s后执行以下代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //隐藏加载动画
        [MBProgressHUD hideHUD];

        //判断用户名与密码是否正确, 只有正确, 才能进行跳转和将信息保存到沙盒中.
        if ([self.accountTextField.text isEqualToString:@"yyh"] && [self.passwordTextField.text isEqualToString:@"123"])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //设置对象
            [defaults setObject:self.accountTextField.text forKey:YHAccount];
            [defaults setObject:self.passwordTextField.text forKey:YHPassword];
            //设置布尔值.
            [defaults setBool:self.rememberSwitch.on forKey:IsRemember];
            [defaults setBool:self.autoLogInSwith.on forKey:IsAutoLogIn];

            //立刻刷新
            [defaults synchronize];

            YHContactTableViewController *contactViewController = [[YHContactTableViewController alloc] init];
            contactViewController.userName = self.accountTextField.text;

            //结束编辑, 收回键盘
            [self.view endEditing:YES];
            //跳转到指定控制器.
            [self.navigationController pushViewController:contactViewController animated:YES];
        }
        else{
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
    });

}
#pragma mark 控制器加载完毕时来到该方法, 做一些初始化的操作,
- (void)viewDidLoad {
    [super viewDidLoad];

    //监听输入框的值的改变
    [self.accountTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];

    //拿到默认设置对象.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    //从默认设置对象中取出相对应的值, 对相应的子控件进行赋值.
    //注意:需要什么样的值, 则调用对应的方法,取什么样的值,如果是bool类型的,则调用 boolForKey .
    self.rememberSwitch.on = [defaults boolForKey:IsRemember];
    self.autoLogInSwith.on = [defaults boolForKey:IsAutoLogIn];

    //如果记住密码为yes, 则拿到偏好, 为文本框赋值,
    if (self.rememberSwitch.on) {

        self.accountTextField.text = [defaults objectForKey:YHAccount];
        self.passwordTextField.text = [defaults objectForKey:YHPassword];
        if (self.autoLogInSwith.on) {
            [self logInButtonClick:self.logInButton];
        }
    }
    [self textChanged];
}
#pragma mark 监听输入框文字改变, 只有都有值时, 按钮才能点击.
- (void)textChanged{
    self.logInButton.enabled = self.accountTextField.text.length && self.passwordTextField.text.length;
}


@end
