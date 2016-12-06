//
//  YHEditViewController.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/6.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHEditViewController.h"
#import "YHAddItem.h"
@interface YHEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation YHEditViewController
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
- (void)initTextField{
    self.userNameTextField.text = self.addItem.userName;
    self.phoneTextField.text = self.addItem.phoneNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
