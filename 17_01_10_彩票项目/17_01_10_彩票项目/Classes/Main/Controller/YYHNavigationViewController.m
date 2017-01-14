//
//  YYHNavigationViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNavigationViewController.h"

@interface YYHNavigationViewController () <UINavigationControllerDelegate>

/** 系统手势代理, 无需关心其类型, 使用id指向*/
@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation YYHNavigationViewController


/**
 重写该方法, 如果是非根控制器, 就更改导航控制器左侧的图标的按钮.
 如果是跟控制器, 则保持系统做法.
 
 重写该方法后会出现无法实现向右滑动回到之前的控制器, 可以
设置self.interactivePopGestureRecognizer.delegate = nil; 但是将系统的滑动移除手势清空当到达栈
 顶控制器的时候如果在向右滑动,就会出现bug,卡死
可以UINavigationControllerDelegate代理方法, 拿到显示完的控制器并加以判断


 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count > 0) {

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoutRendering:@"NavBack"] style:0 target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark -UINavigationControllerDelegate代理方法.

/**
 该方法会返回当前显示完毕的控制器

 在该方法中对返回的控制器进行判断, 如果是根控制器, 则还原手势代理, 如果不是则清除手势代理.
 */
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if ([viewController isKindOfClass:[self.childViewControllers[0] class]]) {
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
    }
    else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)back{
    [self popViewControllerAnimated:YES];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;

}


/**
 initialize方法
 当前类或者他的子类第一次使用的时候调用
 作用:初始化一个类
 */
+ (void)initialize{

    /**
     
     1.appearance是一个协议,只要遵守这个协议的类,都具备这个功能
     2.UIButton UILabel 也有这个功能
     3.如果用appearance就会导致重大bug,整个工程的导航条都一样
     4.我们只要管好自己的事情就可以了 谁用我的导航控制器,我就改下面的类的导航条
     5.采取这种方法
     */
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];

    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];

    [bar setTitleTextAttributes:dict];
}

@end
