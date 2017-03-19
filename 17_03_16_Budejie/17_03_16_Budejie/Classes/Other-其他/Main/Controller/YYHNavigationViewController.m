//
//  YYHNavigationViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNavigationViewController.h"

@interface YYHNavigationViewController ()

@end

@implementation YYHNavigationViewController
+ (void)load{
    //设置导航条的背景图片, 以及字体大小.
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:attr];
}

- (void)viewDidLoad {
    [super viewDidLoad];



}

/**
 点击调回到上一级界面.
 */
- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 什么时候调用:当其他子控制器的压入到NavigationViewController时调用
 作用: 将子控制器压栈, 并显示自控制的view到界面.
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    /*
      // An array of children view controllers. This array does not include any presented view controllers.
     NavigationViewController的childViewControllers属性, 为子控制器的数组, 并不包括以显示的视图控制器, 所以当NavigationViewController中的子控制器大于0时, 才需要显示返回按钮.
     */
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonWithImage:[UIImage imageNamed:@"navigationButtonReturn"]  hightligtedImage:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self action:@selector(back) title:@"返回"];
    }

    [super pushViewController:viewController animated:animated];
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
