//
//  YYHTabBarViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTabBarViewController.h"

#import "YYHArenaViewController.h"
#import "YYHDiscoverTableViewController.h"
#import "YYHHallTableViewController.h"
#import "YYHMyLottoViewController.h"
#import "YYHHistoryTableViewController.h"

#import "YYHTabBar.h"

@interface YYHTabBarViewController ()

/** tabBar Items数组*/
@property (nonatomic, strong) NSMutableArray *itemsArray;

/** <#comments#>*/
@property (nonatomic, weak) UIButton *selButton;
@end

@implementation YYHTabBarViewController

- (NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureAllChildViewController];
    
    [self configureTabBar];


}
- (void)configureTabBar{
    //1.移除系统自带tabBar

    [self.tabBar removeFromSuperview];

    //2. 添加自定义tabBar

    YYHTabBar *tabBar = [[YYHTabBar alloc] init];
    //设置其大小等于系统tabBar大小
    tabBar.frame = self.tabBar.frame;

    tabBar.tabBarItems = self.itemsArray;
    

    [self.view addSubview:tabBar];
}
#pragma mark -加载所有的子控制器
- (void)configureAllChildViewController{

    //竞技场
    YYHArenaViewController *arenaViewController = [[YYHArenaViewController alloc] init];
    arenaViewController.view.backgroundColor = [UIColor orangeColor];

    [self configureOneViewController:arenaViewController
                               image:[UIImage imageNamed:@"TabBar_Arena_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"]];

    //发现
    YYHDiscoverTableViewController *discoverViewController = [[YYHDiscoverTableViewController alloc] init];

    discoverViewController.view.backgroundColor = [UIColor grayColor];

    [self configureOneViewController:discoverViewController
                               image:[UIImage imageNamed:@"TabBar_Discovery_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"]];

    //大厅
    YYHHallTableViewController *hallViewController = [[YYHHallTableViewController alloc] init];

    hallViewController.view.backgroundColor = [UIColor yellowColor];

    [self configureOneViewController:hallViewController
                               image:[UIImage imageNamed:@"TabBar_Hall_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_Hall_selected_new"]];

    //历史
    YYHHistoryTableViewController *historyViewController= [[YYHHistoryTableViewController alloc] init];

    historyViewController.view.backgroundColor = [UIColor blueColor];

    [self configureOneViewController:historyViewController
                               image:[UIImage imageNamed:@"TabBar_History_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_History_selected_new"]];

    //我的
    YYHMyLottoViewController *myLottoViewController= [[YYHMyLottoViewController alloc] init];

    myLottoViewController.view.backgroundColor = [UIColor purpleColor];

    [self configureOneViewController:myLottoViewController
                               image:[UIImage imageNamed:@"TabBar_MyLottery_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"]];

}
#pragma mark -配置每个控制器的图片, 选中图片, 以及添加到TabBarViewController中
- (void)configureOneViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *) selectedImg{

    viewController.tabBarItem.image = image;

    viewController.tabBarItem.selectedImage = selectedImg;

    //将子控制器的 tabBarItem添加到数组
    [self.itemsArray addObject:viewController.tabBarItem];

    //添加子控制器到 TabBarViewController
    [self addChildViewController:viewController];

    

}
@end
