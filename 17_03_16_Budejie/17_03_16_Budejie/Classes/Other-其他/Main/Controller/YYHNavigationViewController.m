//
//  YYHNavigationViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNavigationViewController.h"

@interface YYHNavigationViewController ()<UIGestureRecognizerDelegate>

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

    //并不能设置为nil
//    self.interactivePopGestureRecognizer.delegate = nil;

    //设置该手势代理为当前控制器, 监听手势
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark -----UIGestureRecognizerDelegate方法-----
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //只有当子控制器为非根控制器时, 才允许接收手势.
    return self.childViewControllers.count > 1;
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


    //问题: 当覆盖系统的按钮后, 之前自带的侧滑返回的功能也消失了.
    /*
     手势失效.
     分析:
        1.覆盖后, 手势被清除了.验证: 打印 ==>self.interactivePopGestureRecognizer
     <UIScreenEdgePanGestureRecognizer: 0x7f9c94c0e230; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f9c94c0cd20>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f9c94c0d380>)>>
     说明该手势并没有被清除.
        2. 手势代理进行了一些操作, 导致不能滑动返回.

                尝试:清空手势代理 ==>在非根控制器的情况下, 可以正常实现侧滑返回功能, 但是
                在根控制器下滑动, 会出现程序假死状态.

                解决: 使当前控制器成为self.interactivePopGestureRecognizer的代理,   
                监听滑动, 只有当不是在根控制器的情况下, 才允许接收滑动手势.

     */
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonWithImage:[UIImage imageNamed:@"navigationButtonReturn"]  hightligtedImage:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self action:@selector(back) title:@"返回"];

//        NSLog(@"%@", self.interactivePopGestureRecognizer);
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
