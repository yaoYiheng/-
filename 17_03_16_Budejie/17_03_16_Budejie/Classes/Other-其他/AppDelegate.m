//
//  AppDelegate.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//




#import "AppDelegate.h"
//导入自定义控制器头文件
//#import "YYHEssenceViewController.h"
//#import "YYHFriendViewController.h"
//#import "YYHNewViewController.h"
//#import "YYHPublishViewController.h"
//#import "YYHMeTableViewController.h"

//导入自定义的UITabBarController
#import "YYHTabBarController.h"
#import <AFNetworking.h>

/*
    为应用添加广告页面.
    分析如何实现:
        广告页面也有自己的业务逻辑, 需要单独新建一个类去进行管理, ->创建一个广告文件夹.

    当程序启动后, 首先加载广告页面, 欺骗用户需要加载一定时间, 而在这段时间内展示广告.

        参考源程序, 是一张启动图片, 加上倒计时按钮, 再加上广告, 其他界面一定, 但广告页面不一定, 
        可以使用xib描述该页面, 而为广告页面设置一个空白的占位符.->搭建广告类

 */
#import "YYHAdViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    //1. 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2. 设置窗口根控制器

    /*
     分析: 
     该应该的结构应该是一个UItabBarViewController与 UINavigationController组合的主流框架,
     创建一个UItabBarViewController, 然后为其添加子控制器UINavigationController, 再讲每个模块的控制器设置为UINavigationController的子控制器, 这样就能呈现的是上下方都有条的框架
     */

    //创建根控制器
//    UITabBarController *tabBarVC = [[UITabBarController alloc] init];

    YYHTabBarController *tabBarVC = [[YYHTabBarController alloc] init];

    //首先显示广告页面
//    YYHAdViewController *adVC = [[YYHAdViewController alloc] init];

    //创建各个导航控制器与相关内容的控制器
//    //精华
//    YYHEssenceViewController *essVC = [[YYHEssenceViewController alloc] init];
//    UINavigationController *essNav = [[UINavigationController alloc] initWithRootViewController:essVC];
//    [tabBarVC addChildViewController:essNav];
//    //新帖
//    YYHNewViewController *newVC = [[YYHNewViewController alloc] init];
//    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:newVC];
//    [tabBarVC addChildViewController:newNav];
//    //发布 ->不需要加入导航控制器
//    YYHPublishViewController *publicVC = [[YYHPublishViewController alloc] init];
//
//    [tabBarVC addChildViewController:publicVC];
//    //关注
//    YYHFriendViewController *friendVC = [[YYHFriendViewController alloc] init];
//    UINavigationController *friendNav = [[UINavigationController alloc] initWithRootViewController:friendVC];
//    [tabBarVC addChildViewController:friendNav];
//    //我
//    YYHMeTableViewController *meVC = [[YYHMeTableViewController alloc] init];
//    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
//    [tabBarVC addChildViewController:meNav];
//
//
//
//    //设置各个barItem的图标与文字
//
//    essNav.tabBarItem.title = @"精华";
//    essNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    essNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//
//    // 1:新帖
//    newNav.tabBarItem.title = @"新帖";
//    newNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    newNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//
//    // 2:发布
//    publicVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publicVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon"];
//
//    // 3.关注
//    friendNav.tabBarItem.title = @"关注";
//    friendNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    friendNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//
//    // 4.我
//    meNav.tabBarItem.title = @"我";
//    meNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    meNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];



    //设置为窗口跟控制器
    self.window.rootViewController = tabBarVC;
//    self.window.rootViewController = adVC;

    /*
        完成基本框架搭建, 但出现以下问题:
     1.AppDelegate.m中的代码太过臃肿, 原因在与将UITabBarController的代码写到该文件下不利于维护, 不符合封装思想.
     解决: 自定义UITabBarController.
     
     2. 图片被渲染
     解决: 1.在Assets.xcassets 中全选所有图片文件, 更改Render as为 Original Image 或者
          2.为UIImage类添加分类, 返回一张不带渲染的图片
     
     3. 字体颜色与大小需要修改
     
     4. Publish的图片无法显示.
     
     */

    //3. 使窗口可见
    [self.window makeKeyAndVisible];

    //监听网络状态, 只需设置一次即可

//    // 4.开始监控网络状况
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    NSLog(@"%ld",[[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus]);

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
