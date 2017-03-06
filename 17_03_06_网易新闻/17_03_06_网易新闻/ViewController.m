//
//  ViewController.m
//  17_03_06_网易新闻
//
//  Created by 姚懿恒 on 2017/3/6.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, weak)  UIScrollView *titleScrollView;

@property (nonatomic, weak)  UIScrollView *contentScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建标题滚动条
    [self configureTitleScrollView];

    //创建内容滚动条
    [self configureContentScrollView];

    //设置导航栏标题
    self.navigationItem.title = @"网易新闻";


}
- (void)configureTitleScrollView{
    //1. 创建scrollView
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    //根据NavigationBar来决定y
    CGFloat scrollViewY = self.navigationController.navigationBar? 64 :20;
    titleScrollView.frame = CGRectMake(0, scrollViewY, self.view.bounds.size.width, 44);
    titleScrollView.backgroundColor = [UIColor grayColor];

    [self.view addSubview:titleScrollView];
    _titleScrollView = titleScrollView;

}
- (void)configureContentScrollView{
    //1. 创建scrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    //根据NavigationBar来决定y
    CGFloat scrollViewY = CGRectGetMaxY(self.titleScrollView.frame);
    contentScrollView.frame = CGRectMake(0, scrollViewY, self.view.bounds.size.width, self.view.bounds.size.height - scrollViewY);
    contentScrollView.backgroundColor = [UIColor orangeColor];

    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;

}

@end
