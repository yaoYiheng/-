//
//  YHAddViewController.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHAddViewController.h"
#import "YHAddItem.h"
#import "YHContactTableViewController.h"

@interface YHAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation YHAddViewController

- (IBAction)btnClick:(UIButton *)sender {
    //将从输入框中得到的内容封装到一个类中, 更方便专递.
    YHAddItem *addItem = [YHAddItem addItemWithName:self.nameTextField.text andPhoneNumber:self.numberTextField.text];


    //当点击按钮是调用协议方法, 当代理实现代理方法时, 代理才调用代理方法.
    if ([self.delegate respondsToSelector:@selector(addViewController:addItem:)]) {
        [self.delegate addViewController:self addItem:addItem];
    }

    //返回上一个控制器.
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听文本输入框值的改变
    [self.nameTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.numberTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
}

/**
 当两个文本框都有值时, 改变button的状态.
 */
- (void)textChanged{
    self.addButton.enabled = self.nameTextField.text.length && self.numberTextField.text.length ;
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
