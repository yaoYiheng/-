//
//  AppDelegate.m
//  16_11_21_通过storyboard与xib加载控制器
//
//  Created by 姚懿恒 on 2016/11/21.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "AppDelegate.h"
#import "YHViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];

    YHViewController *viewController = [[YHViewController alloc] initWithNibName:nil bundle:nil];

    //如果将控件的背景颜色设置为clearColor 透明颜色, 则可以响应点击事件.
//    viewController.view.backgroundColor = [UIColor clearColor];

    //如果控件的alpha, 透明度设置为0, 则不能响应点击事件
    viewController.view.alpha = 0;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(50, 50, 50, 50);
    [self.window addSubview:btn];
    [self.window setRootViewController:viewController];

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
