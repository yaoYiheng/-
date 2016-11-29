//
//  YHViewControllerOne.m
//  16_11_28_导航控制器的基本使用及跳转
//
//  Created by 姚懿恒 on 2016/11/28.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHViewControllerOne.h"
#import "YHViewControllerTwo.h"

@interface YHViewControllerOne ()

@end

@implementation YHViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏的标题.
    self.navigationItem.title = @"第一个控制器View";

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //普通状态下的图片.
    [btn setImage:[UIImage imageNamed:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    //高亮状态下的图片
    [btn setImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    //不需要要设置button的位置, 但要设置图片的, 可以通过该方法.
    [btn sizeToFit];

    //为导航栏设置自定义的按钮.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 控制器间的跳转
 */
- (IBAction)jumpToNext {
    YHViewControllerTwo *twoVc = [[YHViewControllerTwo alloc] init];
    [self.navigationController pushViewController:twoVc animated:YES];
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
