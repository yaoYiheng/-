//
//  YHAddContactViewController.m
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHAddContactViewController.h"
#import "YHContactTableViewController.h"
#import "YHContactItems.h"

@interface YHAddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation YHAddContactViewController
- (IBAction)addButtonClick:(UIButton *)sender {
    YHContactItems *contactItem = [YHContactItems contactItemWithName:self.nameTextField.text phone:self.phoneTextField.text];
    if ([self.delegate respondsToSelector:@selector(addContactViewController:contactItem:)]) {
        [self.delegate addContactViewController:self contactItem:contactItem];
        [self.navigationController popViewControllerAnimated:YES];
    }


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self textChanged];
}
- (void)textChanged{
    self.addButton.enabled = self.nameTextField.text.length && self.phoneTextField.text.length;
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
