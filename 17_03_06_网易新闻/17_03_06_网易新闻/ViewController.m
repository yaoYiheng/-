//
//  ViewController.m
//  17_03_06_网易新闻
//
//  Created by 姚懿恒 on 2017/3/6.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
/** <#comments#>*/
@property (nonatomic, weak)  UIScrollView *titleScrollView;

@property (nonatomic, weak)  UIScrollView *contentScrollView;
/** 记录选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
/** 按钮数组*/
@property (nonatomic, strong) NSMutableArray *buttonArray;

/** 记录是否已添加过标题按钮*/
@property (nonatomic, assign) BOOL initialized;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //在即将显示view时, 添加按钮
    //但是该方法会调用多次, 所以添加一个属性来记录
    if (self.initialized == NO) {
        [self configureAllTitleButton];
        self.initialized = YES;
    }



}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建标题滚动条
    [self configureTitleScrollView];

    //创建内容滚动条
    [self configureContentScrollView];

    //设置导航栏标题
    self.navigationItem.title = @"网易新闻";

    //添加标题按钮, 分析:有多少个子控制器, 就对应有多少个按钮, 先添加子控制器




//    NSLog(@"%@", self.titleScrollView.subviews);

    // iOS7以后,导航控制器中scollView顶部会添加64的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    //监听按钮点击


}
- (NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
#pragma mark -----UIScrollViewDelegate-----

/**
 当结束滚动时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    /*
     思路: 根据当前的偏移量, 可以计算出对应的index, 也可以通过该index访问
     按钮数组中的对应的元素.
     */
    //计算当前下标
    NSInteger index = scrollView.contentOffset.x / ScreenW;

    //通过数组拿到对应按钮
    UIButton *titleButton = self.buttonArray[index];

    //当滚动结束时, 需要完成的操作.

    //1. 设置文字跟随滚动而变化
    [self selectButton:titleButton];

    //2. 添加对应子控制器view
    [self configureChildViewControllerWithIndex:index];

}

/**
 在滚动屏幕时, 对即将要显示以及本次选中的按钮做缩放效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //为了实现这个效果, 需要确定:

    //1. 如何获得缩放的按钮
    //2. 如何计算缩放比例
    //通过当前偏移量与屏幕宽的比获得当前页数, 在通过当前页数从数组中获取对应的按钮

    NSInteger leftIndex = scrollView.contentOffset.x / ScreenW;
    NSInteger rightIndex = leftIndex + 1;

    NSInteger count = self.buttonArray.count;

    //通过index获得按钮
    UIButton *leftButton = self.buttonArray[leftIndex];
    UIButton *rightButton;

    //考虑下标越界的问题
    if (rightIndex < count) {
        rightButton = self.buttonArray[rightIndex];
    }

    //当前显示的按钮, 与即将要显示的按钮的比例是成反比的.
    CGFloat rightScale = scrollView.contentOffset.x / ScreenW - leftIndex;

    CGFloat leftScale = 1 - rightScale;

    //根据比例设置按钮的缩放
    //
    leftButton.transform = CGAffineTransformMakeScale(leftScale * 0.5 + 1, leftScale * 0.5 + 1);
    rightButton.transform = CGAffineTransformMakeScale(rightScale * 0.5 + 1, rightScale * 0.5 + 1);

    //根据比例设置标题颜色
    UIColor *leftColor = [UIColor colorWithDisplayP3Red:leftScale green:0 blue:0 alpha:1];

    UIColor *rightColor = [UIColor colorWithDisplayP3Red:rightScale green:0 blue:0 alpha:1];

    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
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

    //在这里进行判断, 如果该view已经被加载, 就不需要再次进行添加
//    if(vc.viewIfLoaded) return; 该API适用与9.0以后的系统.
    if(vc.view.superview) return;

    CGFloat viewX = index * ScreenW;
    vc.view.frame = CGRectMake(viewX, 0, ScreenW, ScreenH);

    [self.contentScrollView addSubview:vc.view];

}
#pragma mark -----选中按钮-----

/**
 该方法设置按钮的选中状态, 以及居中显示
 */
- (void)selectButton:(UIButton *)button{


    self.selectedButton.transform = CGAffineTransformIdentity;

    [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    button.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.selectedButton = button;

    //设置标题居中显示
    [self setupButtonInCenter:button];

}
#pragma mark -----设置标题居中显示-----
- (void)setupButtonInCenter:(UIButton *)button{

    //计算使被点击按钮居中显示的偏移量
    //偏移量 = 被点击的按钮的x - 屏幕宽度的一半
    CGFloat offsetX = button.center.x - ScreenW / 2;

    //最大允许偏移量 = 总宽度 - 屏幕宽度.
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - ScreenW;

    //不需要头两个标题也居中显示, 也不需要最后两个标题居中显示
    if (offsetX < 0) {
        offsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }

    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma mark -----添加子控制器-----


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
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        //为按钮绑定tag
        titleButton.tag = i;

        //为按钮添加点击事件
        [titleButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加到scrollView
        [self.titleScrollView addSubview:titleButton];

        //保存每一个按钮到数组
        [self.buttonArray addObject:titleButton];
        //默认选中第一个按钮
        if (i == 0) {
            [self selectButton:titleButton];
        }
    }

    self.titleScrollView.contentSize = CGSizeMake(count * titleW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;

    //设置内容滚动的范围
    self.contentScrollView.contentSize = CGSizeMake(count * ScreenW, 0);



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
    contentScrollView.backgroundColor = [UIColor blackColor ];

    [self.view addSubview:contentScrollView];
    _contentScrollView = contentScrollView;

    //为contentScrollView设置相关属性

    //增加分页, 取消弹簧以及指示栏
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;

    self.contentScrollView.delegate = self;
}

@end
