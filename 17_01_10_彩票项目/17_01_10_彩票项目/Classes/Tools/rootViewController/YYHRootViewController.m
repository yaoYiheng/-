//
//  YYHRootViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHRootViewController.h"
#import "YYHTabBarViewController.h"
#import "YYHNewFeatureCollectionViewController.h"
#import "YYHSavingTools.h"

@implementation YYHRootViewController

+ (UIViewController *)rootViewController{
    
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
        NSString *lastVersion = [YYHSavingTools objectForKey:@"version"];
    
    
        UIViewController *rootViewController = nil;
        //无更新时, 正常加载进入主框架
        if ([currentVersion isEqualToString:lastVersion]) {
    
            rootViewController  = [[YYHTabBarViewController alloc] init];
        }
        else{
            //有更新或第一次进入时, 从新特性页面加载.
    
            rootViewController = [[YYHNewFeatureCollectionViewController alloc] init];
    
            [YYHSavingTools setObject:currentVersion forKey:@"version"];
            [[NSUserDefaults standardUserDefaults] synchronize];
    
        }

    return rootViewController;
}
@end
