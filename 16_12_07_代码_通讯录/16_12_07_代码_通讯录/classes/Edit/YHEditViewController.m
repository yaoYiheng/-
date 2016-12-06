//
//  YHEditViewController.m
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHEditViewController.h"

@interface YHEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation YHEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:0 target:self action:@selector(editting)];
    [self initWithTextFromContactView];
}
#pragma mark 实现编辑功能
- (void)editting{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]) {
        self.navigationItem.rightBarButtonItem.title = @"取消";
        self.nameTextField.enabled = YES;
        self.phoneTextField.enabled = YES;
        self.saveButton.hidden = NO;
        [self.nameTextField becomeFirstResponder];
    }else{
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.nameTextField.enabled = NO;
        self.phoneTextField.enabled = NO;
        self.saveButton.hidden = YES;
        [self.view endEditing:YES];
        [self initWithTextFromContactView];

    }

}
- (IBAction)saveButtonClick:(UIButton *)sender {
    //更改模型
    self.contactItem.name = self.nameTextField.text;
    self.contactItem.phone = self.phoneTextField.text;

    //向通知中心发生消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textChanged" object:nil];
    //返回上一级
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initWithTextFromContactView{
    self.nameTextField.text = self.contactItem.name;
    self.phoneTextField.text = self.contactItem.phone;
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
