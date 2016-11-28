//
//  YHViewControllerTwo.m
//  16_11_28_导航控制器的基本使用及跳转
//
//  Created by 姚懿恒 on 2016/11/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHViewControllerTwo.h"
#import "YHRootViewController.h"
#import "YHViewControllerOne.h"
@interface YHViewControllerTwo ()

@end

@implementation YHViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 通过该方法跳转到跟控制器.
 */
- (IBAction)jumpToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)jumpToSecond {
    //通过该方法可跳转到指定的控制器, 但必须是导航控制器的自控制.
    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];

    //通过该方法, 跳转到上一个控制器.
    [self.navigationController popViewControllerAnimated:YES];
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
