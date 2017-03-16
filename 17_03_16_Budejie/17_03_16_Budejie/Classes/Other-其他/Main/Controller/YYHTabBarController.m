//
//  YYHTabBarController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/17.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTabBarController.h"

#import "YYHEssenceViewController.h"
#import "YYHFriendViewController.h"
#import "YYHNewViewController.h"
#import "YYHPublishViewController.h"
#import "YYHMeTableViewController.h"

@interface YYHTabBarController ()

@end

@implementation YYHTabBarController

#pragma mark -----配置所有子控制器-----
- (void)configureAllChildViewController{

    //精华
    YYHEssenceViewController *essVC = [[YYHEssenceViewController alloc] init];
    UINavigationController *essNav = [[UINavigationController alloc] initWithRootViewController:essVC];
    [self addChildViewController:essNav];
    //新帖
    YYHNewViewController *newVC = [[YYHNewViewController alloc] init];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:newNav];
    //发布 ->不需要加入导航控制器
    YYHPublishViewController *publicVC = [[YYHPublishViewController alloc] init];

    [self addChildViewController:publicVC];
    //关注
    YYHFriendViewController *friendVC = [[YYHFriendViewController alloc] init];
    UINavigationController *friendNav = [[UINavigationController alloc] initWithRootViewController:friendVC];
    [self addChildViewController:friendNav];
    //我
    YYHMeTableViewController *meVC = [[YYHMeTableViewController alloc] init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:meNav];

    

}

#pragma mark -----设置所有按钮的图片与标题-----
- (void)configureAllBarItems{

    UINavigationController *essNav = self.childViewControllers[0];
    essNav.tabBarItem.title = @"精华";
    essNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];

    // 新帖
    UINavigationController *newNav = self.childViewControllers[1];
    newNav.tabBarItem.title = @"新帖";
    newNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];

    // 发布
    UINavigationController *publicVC = self.childViewControllers[2];
    publicVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
    publicVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon"];

    // 关注
    UINavigationController *friendNav = self.childViewControllers[3];
    friendNav.tabBarItem.title = @"关注";
    friendNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];

    // 4.我
    UINavigationController *meNav = self.childViewControllers[4];
    meNav.tabBarItem.title = @"我";
    meNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
    
    

}
- (void)viewDidLoad {

    [super viewDidLoad];

    [self configureAllChildViewController];


    //设置各个barItem的图标与文字
    [self configureAllBarItems];


}
@end
