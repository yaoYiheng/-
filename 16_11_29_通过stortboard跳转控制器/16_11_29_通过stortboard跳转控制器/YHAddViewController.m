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
    YHAddItem *addItem = [YHAddItem addItemWithName:self.nameTextField.text andPhoneNumber:self.numberTextField.text];

    self.contantViewController.addItem = addItem;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.numberTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
}
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
