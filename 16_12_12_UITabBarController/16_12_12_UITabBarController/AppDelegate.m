//
//  AppDelegate.m
//  16_12_12_UITabBarController
//
//  Created by 姚懿恒 on 2016/12/12.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "AppDelegate.h"
#import "massageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    //创建窗口
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
//    //创建tabBarController控制器.
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//
//    //创建UITableViewController
//    UITableViewController *tableVC = [[UITableViewController alloc] init];
//    //为对应的控制器设置标题以及图片
//    tableVC.tabBarItem.title = @"个人";
//    tableVC.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor"];
//
//    //创建导航控制器.
//    UINavigationController *navigationVC =[[UINavigationController alloc] initWithRootViewController:tableVC];
//
//    UITableViewController *tableVC1 = [[UITableViewController alloc] init];
//    tableVC1.tabBarItem.title = @"动态";
//
//    //可以以数组的形式添加tabBarController的子控件, 一开始显示的为最先添加的控制器(索引为0的控制器)
//    tabBarController.viewControllers = @[tableVC1,navigationVC];
//
//    //或者通过以下方法添加子控制器.
//    //[tabBarController addChildViewController:tabBarController];
//    //设置窗口根控制器为导航控制器.
//    self.window.rootViewController = tabBarController;
//    [self.window makeKeyAndVisible];

        /**********************/

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    //创建tabBarController
    UITabBarController *mainTabBarVC = [[UITabBarController alloc] init];

    //导航控制器1--消息
    massageViewController *massageTableVC = [[massageViewController alloc] init];
    UINavigationController *navigationVC1  =[[UINavigationController alloc] initWithRootViewController:massageTableVC];
    massageTableVC.tabBarItem.title = @"消息";
    massageTableVC.tabBarItem.badgeValue = @"10";
    massageTableVC.tabBarItem.image = [UIImage imageNamed:@"tab_recent_nor"];

    //导航控制2--动态
    UITableViewController *statusTableViewController = [[UITableViewController alloc] init];
    UINavigationController *navigationVC2  =[[UINavigationController alloc] initWithRootViewController:statusTableViewController];
    //设置title属性, 可以为两个状态栏上的title赋值.
    statusTableViewController.title = @"动态";
    statusTableViewController.tabBarItem.image = [UIImage imageNamed:@"tab_qworld_nor"];



    //导航控制器3 -- 人物
    UITableViewController *personTableViewController = [[UITableViewController alloc] init];
    UINavigationController *navigationVC3  =[[UINavigationController alloc] initWithRootViewController:personTableViewController];
    personTableViewController.tabBarItem.title = @"个人";
    personTableViewController.tabBarItem.image = [UIImage imageNamed:@"tab_buddy_nor"];

    //导航控制4  ---- 设置
    UITableViewController *settingTableViewController = [[UITableViewController alloc] init];
    UINavigationController *navigationVC4  =[[UINavigationController alloc] initWithRootViewController:settingTableViewController];
    settingTableViewController.title = @"设置";
    settingTableViewController.tabBarItem.image = [UIImage imageNamed:@"tab_me_nor"];


    mainTabBarVC.viewControllers = @[navigationVC1, navigationVC2, navigationVC3, navigationVC4];



    self.window.rootViewController = mainTabBarVC;
    [self.window makeKeyAndVisible];
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
