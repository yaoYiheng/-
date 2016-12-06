//
//  YHEditViewController.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/6.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHEditViewController.h"
#import "YHAddItem.h"
@interface YHEditViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation YHEditViewController

#pragma mark 当点击编辑时, 更改子控件的状态
- (IBAction)editting:(UIBarButtonItem *)sender {

    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"取消";
        self.userNameTextField.enabled = YES;
        self.phoneTextField.enabled = YES;
        self.saveButton.hidden = NO;
        [self.userNameTextField becomeFirstResponder];

    }else{
        sender.title = @"编辑";
        self.userNameTextField.enabled = NO;
        self.phoneTextField.enabled = NO;
        self.saveButton.hidden = YES;

        //如果有改变, 则提示用户是否放弃更改.

        //如果没有值的改变, 则放弃保存.
        [self initTextField];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextField];

}
#pragma mark 抽出使用两边的藏法.
- (void)initTextField{
    self.userNameTextField.text = self.addItem.userName;
    self.phoneTextField.text = self.addItem.phoneNumber;
}



#pragma 点击保存按钮时
- (IBAction)saveButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    //将用户从文本输入框的值赋给addItem
    self.addItem.userName = self.userNameTextField.text;
    self.addItem.phoneNumber = self.phoneTextField.text;
    //调用代理方法.
    if ([self.delegate respondsToSelector:@selector(edittingViewController:addItem:)]) {
        [self.delegate edittingViewController:self addItem:self.addItem];
    }
    //返回上一控制器
    [self.navigationController popViewControllerAnimated:YES];
}

@end
