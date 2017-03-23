//
//  YYHLogNRegisterViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHLogNRegisterViewController.h"
#import "YYHInputView.h"

@interface YYHLogNRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middlePlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *bottomPlaceHolderView;

@end

@implementation YYHLogNRegisterViewController
- (IBAction)registerButtonClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    YYHInputView *middleView = [YYHInputView middleView];

    [self.middlePlaceHolderView addSubview:middleView];
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
