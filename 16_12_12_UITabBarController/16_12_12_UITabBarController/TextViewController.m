//
//  TextViewController.m
//  16_12_12_UITabBarController
//
//  Created by 姚懿恒 on 2016/12/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButtonClick;

@end

@implementation TextViewController
- (IBAction)backButtonClick:(UIButton *)sender
{
    //调用dismissViewContr<#^(void)completion#>ollerAnimated:<#(BOOL)#> completion:返回modal出来的控制器.
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"pass");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
