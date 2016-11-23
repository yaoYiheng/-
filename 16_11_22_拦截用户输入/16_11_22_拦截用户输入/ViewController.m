//
//  ViewController.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *contryTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

/**
 是否允许开始编辑

 @return 如果返回NO, 则无法弹出键盘
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

/**
 当文本框成为第一响应者时会来到此方法;

 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%s", __func__);
}

/**
 是否允许退出编辑

 @return 如果返回NO, 则无法退出当前编辑的文本框
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

/**
 是否允许输入的内容替换到输入框中(可完成拦截用户输入的功能)

 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
