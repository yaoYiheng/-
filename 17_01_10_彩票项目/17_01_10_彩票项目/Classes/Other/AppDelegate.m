//
//  AppDelegate.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "AppDelegate.h"


#import "YYHRootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];


    //添加新特性界面.


    /**
    
     在该方法(

     - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)中判断.
     

     当版本有更新, 或是第一次运行界面时, 跳转到显示新特性界面, 如果不是,则进入主框架.
     
     需要在偏好设置中保存版本号.
     [NSUserDefaults standardUserDefaults]
     
     关于获取当前版本号
     
     Info.plist文件以 source code打开, 找到 CFBundleShortVersionString 的key.

     比较当前版本号与最新版本号, 
     如果相等, 则进入主框架
     如果不相等, 则跳转到新特性界面, 并将当前版本号同步到偏好设置中.

     
     */
//
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
//
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
//
//
//    UIViewController *rootViewController = nil;
//    //无更新时, 正常加载进入主框架
//    if ([currentVersion isEqualToString:lastVersion]) {
//
//        rootViewController  = [[YYHTabBarViewController alloc] init];
//    }
//    else{
//        //有更新或第一次进入时, 从新特性页面加载.
//
//        rootViewController = [[YYHNewFeatureCollectionViewController alloc] init];
//
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"version"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//    }

//    YYHNewFeatureCollectionViewController *newFeature = [[YYHNewFeatureCollectionViewController alloc] init];
//
//    self.window.rootViewController = newFeature;

    self.window.rootViewController = [YYHRootViewController rootViewController];
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
