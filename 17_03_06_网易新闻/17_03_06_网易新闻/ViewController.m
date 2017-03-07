//
//  ViewController.m
//  17_03_06_网易新闻
//
//  Created by 姚懿恒 on 2017/3/6.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "TopLineViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "SocietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, weak)  UIScrollView *titleScrollView;

@property (nonatomic, weak)  UIScrollView *contentScrollView;
/** 记录选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
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

    //添加标题按钮, 分析:有多少个子控制器, 就对应有多少个按钮, 先添加子控制器
    [self configureChildrenViewController];

    //添加按钮
    [self configureAllTitleButton];


    // iOS7以后,导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    //监听按钮点击


}
#pragma mark -----按钮点击事件-----
- (void)buttonOnClick:(UIButton *)button{
    /*
     需求:1. 点击时, 被点击的按钮文字变颜色, 点击别的时, 取消变色
         2. 添加对应的子控制器的view
         3. 移动到对应的显示区域
     */
    [self selectButton:button];

    NSInteger index = button.tag;

    [self configureChildViewControllerWithIndex:index];

    self.contentScrollView.contentOffset = CGPointMake(index * ScreenW, 0);


}
#pragma mark -----通过绑定的tag添加对应的子控制器view-----
- (void)configureChildViewControllerWithIndex:(NSInteger)index{

    UIViewController *vc = self.childViewControllers[index];
    CGFloat viewX = index * ScreenW;
    vc.view.frame = CGRectMake(viewX, 0, ScreenW, ScreenH);

    [self.contentScrollView addSubview:vc.view];

}
#pragma mark -----选中按钮-----
- (void)selectButton:(UIButton *)button{
    [self.selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];

    self.selectedButton = button;

}
#pragma mark -----添加子控制器-----

-(void)configureChildrenViewController{
    //头条
    TopLineViewController *top = [TopLineViewController new];
    top.title = @"头条";
    [self addChildViewController:top];

    //热点
    HotViewController *hot = [HotViewController new];
    hot.title = @"热点";
    [self addChildViewController:hot];

    //视频
    VideoViewController *video = [VideoViewController new];
    video.title = @"视频";
    [self addChildViewController:video];

    //社会
    SocietyViewController *soci = [SocietyViewController new];
    soci.title = @"社会";
    [self addChildViewController:soci];

    //订阅
    ReaderViewController *reader = [ReaderViewController new];
    reader.title = @"订阅";
    [self addChildViewController:reader];

    //科技
    ScienceViewController *sci = [ScienceViewController new];
    sci.title = @"科技";
    [self addChildViewController:sci];

}
#pragma mark -----添加子控制器按钮-----
- (void)configureAllTitleButton{

    NSInteger count = self.childViewControllers.count;
    CGFloat titleX = 0;
    CGFloat titleW = 100;
    CGFloat titleH = self.titleScrollView.bounds.size.height;


    //遍历创建所有的按钮, 并设置尺寸大小并添加到scrollView上.
    for (int i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮大小尺寸
        titleX = i * titleW;
        titleButton.frame = CGRectMake(titleX, 0, titleW, titleH);
        //拿到对应的子控制器
        UIViewController *vc = self.childViewControllers[i];
        //设置标题
        [titleButton setTitle:vc.title forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        //为按钮绑定tag
        titleButton.tag = i;

        //为按钮添加点击事件
        [titleButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加到scrollView
        [self.titleScrollView addSubview:titleButton];

        //默认选中第一个按钮
        if (i == 0) {
            [self selectButton:titleButton];
        }
    }

    self.titleScrollView.contentSize = CGSizeMake(count * titleW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;

    //设置内容滚动的范围
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;


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
