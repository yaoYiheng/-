//
//  YYHArenaNavViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/13.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHArenaNavViewController.h"

@interface YYHArenaNavViewController ()

@end

@implementation YYHArenaNavViewController


+ (void)initialize{

    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];

    UIImage *image = [UIImage imageWithStretched:@"NLArenaNavBar64"];

    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
