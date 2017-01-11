//
//  YYHNavigationViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNavigationViewController.h"

@interface YYHNavigationViewController ()

@end

@implementation YYHNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    UINavigationBar *bar = [UINavigationBar appearance];

    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];

    [bar setTitleTextAttributes:dict];
}

@end
