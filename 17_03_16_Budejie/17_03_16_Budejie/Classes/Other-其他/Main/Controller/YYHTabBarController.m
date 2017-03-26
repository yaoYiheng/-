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
#import "YYHNavigationViewController.h"
#import "YYHTabBar.h"

@interface YYHTabBarController ()

@end

@implementation YYHTabBarController

/*
 完成基本框架搭建, 但出现以下问题:
 1.AppDelegate.m中的代码太过臃肿, 原因在与将UITabBarController的代码写到该文件下不利于维护, 不符合封装思想.
 解决: 自定义UITabBarController.

 2. 图片被渲染

 解决: 1.在Assets.xcassets 中全选所有图片文件, 更改Render as为 Original Image 或者
      2.为UIImage类添加分类, 返回一张不带渲染的图片

 3. 字体颜色与大小需要修改 
 解决:拿到对应子类的tabBarItem, 调用
 - (void)setTitleTextAttributes:(nullable NSDictionary<NSString *,id> *)attributes forState:(UIControlState)state 对字体颜色进行修改
 注意: 设置字体尺寸:只有设置正常状态下,才会有效果


 4. Publish的图片无法显示, 且位置偏上.
    解决:
        方案一: 传入一张通过调整没进过渲染的图片, 且通过修改tabBarItem的imageInsets内边距调整,但是并没有达到源程序的效果.所以不能通过该方法.
 
    分析: 源程序点击发布按钮后, 以modal效果弹出自控制的view, 当modal效果取消后, 按钮会成为普通状态, 说明源程序发布按钮并不是系统的tabBarButton(不带有高亮状态),  tabBarButton对应不同的子控制器, 既然发布按钮不是tabBarButton, 发布模块也就没有必要成为tabBarViewController的子控制器.

    最终解决方案: 
            自定义tabBarItem, 调整添加在tabBarViewController里的子控件对应的tabBarButton的位置, 为发布按钮留出中间的位置, 将发布按钮添加到自定义的tabBarItem上.
            
            问题:tabBarViewController里的子控件对应的tabBarButton(UITabBarItem)什么时候添加到tabBar上?
            答: 当viewWillAppear:(BOOL)animated调用时, 会添加tabBarButton(UITabBarItem)



 */
#pragma mark -----控制器view生命周期方法-----

+ (void)load{
    UITabBarItem *barItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];

    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attriDict = [NSMutableDictionary dictionary];
    attriDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [barItem setTitleTextAttributes:attriDict forState:UIControlStateSelected];


    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrNomal = [NSMutableDictionary dictionary];
    attrNomal[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [barItem setTitleTextAttributes:attrNomal forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {

    [super viewDidLoad];

    [self configureAllChildViewController];
    

    //设置各个barItem的图标与文字
    [self configureAllBarItems];


    //替换系统的tabBarItem
    [self configureCustomedTabBarItem];


}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//
//    NSLog(@"%@", self.tabBar.items);
//
//}

#pragma mark -----添加自定义的tabBarItem-----
- (void)configureCustomedTabBarItem{

    //tabBar就是底部装载按钮的那个横条, tabBar中显示的按钮就是UITabBarItem
    YYHTabBar *tabBar = [[YYHTabBar alloc] init];
    /*
        使用KVC替换掉系统的tabBar, 为自定义的YYHTabBar
     无法通过set方法进行修改, 因为该属性为readonly, 所以使用KVC对其进行修改.
     */
//    self.tabBar = tabBar;
    [self setValue:tabBar forKey:@"tabBar"];

}
#pragma mark -----配置所有子控制器-----
- (void)configureAllChildViewController{

    //精华
    YYHEssenceViewController *essVC = [[YYHEssenceViewController alloc] init];
    YYHNavigationViewController *essNav = [[YYHNavigationViewController alloc] initWithRootViewController:essVC];
    [self addChildViewController:essNav];
    //新帖
    YYHNewViewController *newVC = [[YYHNewViewController alloc] init];
    YYHNavigationViewController *newNav = [[YYHNavigationViewController alloc] initWithRootViewController:newVC];
    [self addChildViewController:newNav];
    //发布 ->不需要加入导航控制器
//    YYHPublishViewController *publicVC = [[YYHPublishViewController alloc] init];
//    publicVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);

//    [self addChildViewController:publicVC];
    //关注
    YYHFriendViewController *friendVC = [[YYHFriendViewController alloc] init];
    YYHNavigationViewController *friendNav = [[YYHNavigationViewController alloc] initWithRootViewController:friendVC];
    [self addChildViewController:friendNav];
    //我
    //我控制器view从storyboard中加载,
    UIStoryboard *strbo = [UIStoryboard storyboardWithName:NSStringFromClass([YYHMeTableViewController class]) bundle:nil];

    YYHMeTableViewController *meVC = [strbo instantiateInitialViewController];
    YYHNavigationViewController *meNav = [[YYHNavigationViewController alloc] initWithRootViewController:meVC];
    [self addChildViewController:meNav];

    

}

#pragma mark -----设置所有按钮的图片与标题-----
- (void)configureAllBarItems{

    YYHNavigationViewController *essNav = self.childViewControllers[0];
    essNav.tabBarItem.title = @"精华";
    essNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essNav.tabBarItem.selectedImage = [UIImage imageWithoutRendering:@"tabBar_essence_click_icon"];

    // 新帖
    YYHNavigationViewController *newNav = self.childViewControllers[1];
    newNav.tabBarItem.title = @"新帖";
    newNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newNav.tabBarItem.selectedImage = [UIImage imageWithoutRendering:@"tabBar_new_click_icon"];

    // 发布
//    UINavigationController *publicVC = self.childViewControllers[2];
//    publicVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publicVC.tabBarItem.selectedImage = [UIImage imageWithoutRendering:@"tabBar_publish_click_icon"];

    // 关注
    YYHNavigationViewController *friendNav = self.childViewControllers[2];
    friendNav.tabBarItem.title = @"关注";
    friendNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendNav.tabBarItem.selectedImage = [UIImage imageWithoutRendering:@"tabBar_friendTrends_click_icon"];

    // 4.我
    YYHNavigationViewController *meNav = self.childViewControllers[3];
    meNav.tabBarItem.title = @"我";
    meNav.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meNav.tabBarItem.selectedImage = [UIImage imageWithoutRendering:@"tabBar_me_click_icon"];
    
    
    

}

@end
