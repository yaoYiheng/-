//
//  YYHLogNRegisterViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHLogNRegisterViewController.h"
#import "YYHRegisterView.h"

@interface YYHLogNRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middlePlaceHolderView;
@property (weak, nonatomic) IBOutlet UIView *bottomPlaceHolderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;


@end

@implementation YYHLogNRegisterViewController
- (IBAction)registerButtonClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    _leading.constant = _leading.constant == 0? -self.middlePlaceHolderView.yyh_width * 0.5:0;
    [UIView animateWithDuration:0.3 animations:^{
        //做布局时需要用到的方法.
        [self.view layoutIfNeeded];
    }];

}

/**
 以modal方式退出当前控制器view.
 */
- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    YYHRegisterView *logInView = [YYHRegisterView logInView];

    [self.middlePlaceHolderView addSubview:logInView];

    YYHRegisterView *registerView = [YYHRegisterView registerView];

    [self.middlePlaceHolderView addSubview:registerView];


}

/**
 从xib加载的控件, 一定需要在重新确认下子控件的frame.
 在viewDidLoad方法中布局子控件的frame时, 控件的尺寸来自于xib的大小, 
 在开发中会在viewDidLayoutSubviews中布局子控件.
 */
- (void)viewDidLayoutSubviews
{
    // 一定要调用super
    [super viewDidLayoutSubviews];

    // 设置登录view
    YYHRegisterView *loginView = self.middlePlaceHolderView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middlePlaceHolderView.yyh_width * 0.5, self.middlePlaceHolderView.yyh_height);
    YYHRegisterView *registerView = self.middlePlaceHolderView.subviews[1];
    registerView.frame = CGRectMake(self.middlePlaceHolderView.yyh_width * 0.5, 0, self.middlePlaceHolderView.yyh_width * 0.5, self.middlePlaceHolderView.yyh_height);
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
