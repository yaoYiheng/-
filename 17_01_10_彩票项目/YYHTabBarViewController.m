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
#import "YYHNavigationViewController.h"

@interface YYHTabBarViewController () <YYHTabBarDelegate>

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

    //设置代理
    tabBar.delegate = self;

    [self.view addSubview:tabBar];
}
#pragma mark -YYHTabBarDelegate代理方法
- (void)tabBar:(YYHTabBar *)tabBar index:(NSInteger)index{
    self.selectedIndex = index;
}
#pragma mark -加载所有的子控制器
- (void)configureAllChildViewController{

    //大厅
    YYHHallTableViewController *hallViewController = [[YYHHallTableViewController alloc] init];

    hallViewController.view.backgroundColor = [UIColor yellowColor];

    [self configureOneViewController:hallViewController
                               image:[UIImage imageNamed:@"TabBar_Hall_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_Hall_selected_new"]
                                title:@"购彩大厅"];

    //竞技场
    YYHArenaViewController *arenaViewController = [[YYHArenaViewController alloc] init];
    arenaViewController.view.backgroundColor = [UIColor orangeColor];

    [self configureOneViewController:arenaViewController
                               image:[UIImage imageNamed:@"TabBar_Arena_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_Arena_selected_new"]
                               title:nil];

    //发现
    YYHDiscoverTableViewController *discoverViewController = [[YYHDiscoverTableViewController alloc] init];

    discoverViewController.view.backgroundColor = [UIColor grayColor];

    [self configureOneViewController:discoverViewController
                               image:[UIImage imageNamed:@"TabBar_Discovery_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_Discovery_selected_new"]
                               title:@"发现"];



    //历史
    YYHHistoryTableViewController *historyViewController= [[YYHHistoryTableViewController alloc] init];

    historyViewController.view.backgroundColor = [UIColor blueColor];

    [self configureOneViewController:historyViewController
                               image:[UIImage imageNamed:@"TabBar_History_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_History_selected_new"]
                               title:@"开奖信息"];

    //我的
    YYHMyLottoViewController *myLottoViewController= [[YYHMyLottoViewController alloc] init];

    myLottoViewController.view.backgroundColor = [UIColor purpleColor];

    [self configureOneViewController:myLottoViewController
                               image:[UIImage imageNamed:@"TabBar_MyLottery_new"]
                       selectedImage:[UIImage imageNamed:@"TabBar_MyLottery_selected_new"]
                               title:@"我的彩票"];

}
#pragma mark -配置每个控制器的图片, 选中图片, 以及添加到TabBarViewController中
- (void)configureOneViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *) selectedImg title:(NSString *)title{





    UINavigationController *nav = [[YYHNavigationViewController alloc] initWithRootViewController:viewController];


    viewController.tabBarItem.image = image;

    viewController.tabBarItem.selectedImage = selectedImg;
    
    viewController.navigationItem.title = title;


    //将子控制器的 tabBarItem添加到数组
    [self.itemsArray addObject:viewController.tabBarItem];
    //添加子控制器到 TabBarViewController
    [self addChildViewController:nav];

    

}
@end
