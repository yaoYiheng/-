//
//  ViewController.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/11/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+XMG.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogIn;
@property (weak, nonatomic) IBOutlet UISwitch *remPassword;

@end

@implementation ViewController
- (IBAction)logIn:(UIButton *)sender {

    //使用框架显示加载时,想要显示的文字.
    [MBProgressHUD showMessage:@"努力加载中..." toView:self.view];
    //设置延迟时间, 在延迟结束后想要实现的代码在block中完成.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //延迟结束后, 隐藏加载时显示的文字.
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //对输入结果进行判断, 只有当用户名与密码都正确时, 才能跳转到下一个界面.
        if ([self.accountText.text isEqualToString:@"yyh"] && [self.pwdTextField.text isEqualToString:@"123"]) {

            //调用该方法完成跳转到指定的控制器
            [self performSegueWithIdentifier:@"contactViewController" sender:nil];
            //结束编辑状态, 隐藏键盘.
            [self.view endEditing: YES];
        }else{

            [MBProgressHUD showError:@"用户名或密码错误"];
        }

    });


}

- (void)viewDidLoad {
    [super viewDidLoad];

    //监听文本输入框的改变.
    [self.accountText addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self textChanged];
}

/**
 只有当两个文本框都有值时, 才会更改登录按钮的状态.
 */
- (void)textChanged{
    self.logInButton.enabled = self.accountText.text.length && self.pwdTextField.text.length;
}
//想要自动登录的话, 就必须记住密码.
- (IBAction)autoLogIn:(UISwitch *)sender {
    if (sender.on == YES) {
        [self.remPassword setOn:YES animated:YES];
    }
    
}
//如果不记住密码, 也不能自动登录.
- (IBAction)remPassword:(UISwitch *)sender {
    if (sender.on == NO) {
        [self.autoLogIn setOn:NO animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
