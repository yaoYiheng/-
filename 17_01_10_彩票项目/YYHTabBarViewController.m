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
#import "YYHArenaNavViewController.h"


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
#pragma mark -view生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureAllChildViewController];
    
    [self configureTabBar];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //遍历系统自带tabBar的子控件, 移除不是自定义的控件
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[YYHTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}
- (void)configureTabBar{
    //1.移除系统自带tabBar

    //不能直接移除系统自带的tabBar, 因为无法实现hide bottom bar on push
//    [self.tabBar removeFromSuperview];

    //2. 添加自定义tabBar

    YYHTabBar *tabBar = [[YYHTabBar alloc] init];
    //设置其大小等于系统tabBar大小
    //自定义的frame等于系统tabBar的bounds
    tabBar.frame = self.tabBar.bounds;

    tabBar.tabBarItems = self.itemsArray;

    //设置代理
    tabBar.delegate = self;

    //添加到tabBar上而不是self.view中.
    [self.tabBar addSubview:tabBar];
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
    //加载storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([YYHDiscoverTableViewController class]) bundle:nil];

    //初始化箭头指向的控制器
    YYHDiscoverTableViewController *discoverViewController = [storyboard instantiateInitialViewController];
//
//    discoverViewController.view.backgroundColor = [UIColor grayColor];

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
    if ([viewController isKindOfClass:[YYHArenaViewController class]]) {
        nav = [[YYHArenaNavViewController alloc] initWithRootViewController:viewController];
    }


    viewController.tabBarItem.image = image;

    viewController.tabBarItem.selectedImage = selectedImg;
    
    viewController.navigationItem.title = title;


    //将子控制器的 tabBarItem添加到数组
    [self.itemsArray addObject:viewController.tabBarItem];
    //添加子控制器到 TabBarViewController
    [self addChildViewController:nav];

    

}
@end
