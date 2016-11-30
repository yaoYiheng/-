//
//  ViewController.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/11/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogIn;
@property (weak, nonatomic) IBOutlet UISwitch *remPassword;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //监听文本输入框的改变.
    [self.accountText addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
