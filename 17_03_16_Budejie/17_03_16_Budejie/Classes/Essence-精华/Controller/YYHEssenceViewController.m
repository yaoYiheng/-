//
//  YYHEssenceViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
    UITableView重要属性分析:

 什么是内容？内容包括什么？
 1.cell
 2.tableHeaderView\tableFooterView
 3.sectionHeader\sectionFooter

 contentSize.height : 所有内容的总高度 = cell高度 + tableHeaderView\tableFooterView高度 + sectionHeader\sectionFooter高度

 contentInset : 在内容周围额外增加的间距（内边距），始终粘着内容

 contentOffset : 内容距离frame矩形框，偏移了多少
        contentOffset.y = tableView.y与tableView的所有内容的总高度的差值.

 frame : 是以父控件内容的左上角为坐标原点{0, 0}

 bounds : 是以自己内容的左上角为坐标原点{0, 0}

 */

/*
    如果想要实现可以透过导航条与tabBar看到tableView上显示的内容的话, 需要设置scrollView的全屏显示, 但是在导航控制器的view下会自动偏移
 需要设置self.automaticallyAdjustsScrollViewInsets = NO;
    
    既想要实现穿透可视, 有想要tableView的可视内容不被导航条与tabBar挡住, 
 需要同时设置self.automaticallyAdjustsScrollViewInsets = NO, 以及为tableView的顶部与底部设置内边距(contentInset)
 
    接下来要做的事:
        1. 点击对应按钮跳转到对应的控制器的view -> 点击按钮, 通过绑定的tag设置scrollView的偏移量 ✅
        2. 滑动实现标题按钮的联动 ->监听scrollView的滑动, 实现代理方法, 在代理方法中调用点击按钮的方法即可实现.✅
    
    存在的问题:
        当添加子控制器view到scrollView时, 会将所有view创建并加载, 这样性能不好, 应该做到用到时才加载, 
        可以将加载的代码放到scrollView滚动完毕时调用.

 */
#import "YYHEssenceViewController.h"
#import "YYHTitleButton.h"
#import "YYHAllTableViewController.h"
#import "YYHVideoTableViewController.h"
#import "YYHSoundTableViewController.h"
#import "YYHPictureTableViewController.h"
#import "YYHWordTableViewController.h"



@interface YYHEssenceViewController () <UIScrollViewDelegate>
/** 标题栏view*/
@property (nonatomic, weak) UIView *titleView;
/** 选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
/** 下划线*/
@property (nonatomic, weak) UIView *underLine;
/** 装载所有子控制器view的scrollView*/
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation YYHEssenceViewController

#pragma mark -----view生命周期方法-----
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏按钮
    [self configureBarButtonItem];

    //为当前(精华)控制器添加子控制器
    [self configureChildrenViewControllers];

    //添加scrollView

    [self configureScrollView];

    //添加标题栏
    [self configureTitleView];

    //当把scrollView添加到带有导航控制器的view当中时, 会自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;

    //精华控制器view加载完毕时, 加载allViewController的view
    [self addChildViewIntoScrollView:0];
}
#pragma mark -----UIScrollViewDelegate-----

/**
 当停止减速, 即完全静止时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //通过偏移量拿到index, 可以通过该index获取到对应的按钮
    NSInteger index = scrollView.contentOffset.x / YYhScreenW;

    //方法一: 通过该index在titleView的数组中获取
    YYHTitleButton *button = self.titleView.subviews[index];

    //方法而: 通过该index, 调用viewWithTag:获取
    /*
     报错:-[UIView setSelected:]: unrecognized selector sent to instance 0x7fca6bc0b390.
     原因是向UIView发送了setSelected消息,但UIView中并没有该方法.
     
     分析报错原因:
     viewWithTag:该方法的实现是采用递归遍历, 先查询自己的tag, 再去查询自己子view的tag, 默认控件的tag为0, 而第一个按钮的tag值也为0,
     所有通过该方法传递出来的UIView并不是按钮, 而是titleView本身(UIView), 当该view作为参数传递给另一个需要接受按钮的方法中, 设置按钮
     相关方法时, 就会报找不到方法的错误.
     
     5   17_03_16_Budejie                    0x000000010491c0b6 -[YYHEssenceViewController titleButtonClick:] + 150
     6   17_03_16_Budejie                    0x000000010491ad2b -[YYHEssenceViewController scrollViewDidEndDecelerating:] + 331
     */

//    YYHTitleButton *button = [self.titleView viewWithTag:index];

    //调用点击按钮方法
    [self titleButtonClick:button];

}
#pragma mark -----初始化子控件-----

/**
 为当前控制器添加所有子控制器
 */
- (void)configureChildrenViewControllers{

    [self addChildViewController:[[YYHAllTableViewController alloc] init]];
    [self addChildViewController:[[YYHVideoTableViewController alloc] init]];
    [self addChildViewController:[[YYHSoundTableViewController alloc] init]];
    [self addChildViewController:[[YYHPictureTableViewController alloc] init]];
    [self addChildViewController:[[YYHWordTableViewController alloc] init]];

}

/**
 为scrollView添加子控制器的view
 */
- (void)configureChildrenViews{
    NSInteger count = self.childViewControllers.count;
    self.scrollView.contentSize = CGSizeMake(count * YYhScreenW, 0);
    //添加子控制器view到scrollView
//    for (int i = 0; i < count; i++) {
//        UIView *childView = self.childViewControllers[i].view;
//        childView.frame = CGRectMake(i * YYhScreenW, 0, YYhScreenW, YYHScreenH);
//
//        [self.scrollView addSubview:childView];
//    }

}
/**
 设置ScrollView
 */
- (void)configureScrollView{
    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor cyanColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;



    self.scrollView = scrollView;

    //添加所有子控制器的view到scrollView
    [self configureChildrenViews];

    [self.view addSubview:scrollView];

}

/**
 设置标题栏view
 */
- (void)configureTitleView{
    //添加标题view
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    CGFloat titleViewW = self.view.yyh_width;
    CGFloat titleViewH = YYHTitleViewHeight;
    //设置titleView尺寸
    titleView.frame = CGRectMake(0, 64, titleViewW, titleViewH);
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];

    //为其添加子按钮
    [self addTitleButtons];

    [self.view addSubview:titleView];

    //添加下划线
    [self addUnderLine];

}
- (void)addUnderLine{
    //第一个按钮为选中状态
    YYHTitleButton *firstButton = self.titleView.subviews.firstObject;

    firstButton.selected = YES;
    self.selectedButton = firstButton;

    //创建下划线
    UIView *underLine = [[UIView alloc] init];
    //设置下划线位置
    underLine.yyh_height = 2;
    underLine.yyh_y = self.titleView.yyh_height - underLine.yyh_height;
    underLine.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    self.underLine = underLine;

    //通过按钮拿到label宽度
    [firstButton.titleLabel sizeToFit];
    underLine.yyh_width = firstButton.titleLabel.yyh_width;
    underLine.yyh_centerX = firstButton.yyh_centerX;


    [self.titleView addSubview:underLine];
}
- (void)addTitleButtons{


    NSArray *titleArray = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat buttonW = self.view.yyh_width / 5;
    CGFloat buttonH = self.titleView.yyh_height;

    for (int i = 0;  i < 5; i++) {
        YYHTitleButton *titleButton = [YYHTitleButton buttonWithType:UIButtonTypeCustom];

        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);

        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];

        //为按钮绑定tag
        titleButton.tag = i;

        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.titleView addSubview:titleButton];
    }

}
#pragma mark -----点击标题按钮-----
- (void)titleButtonClick: (YYHTitleButton *)titleButton{
    YYHFunc
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;

    self.underLine.backgroundColor = [titleButton currentTitleColor];

    //点击标题后, 跳转到对应的控制器的view, 通过改变scrollView的的contentOffset
    NSUInteger index = titleButton.tag;

    //点击按钮时, 移动下划线的位置
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.yyh_width = titleButton.titleLabel.yyh_width;
        self.underLine.yyh_centerX = titleButton.yyh_centerX;


        self.scrollView.contentOffset = CGPointMake(index * YYhScreenW, self.scrollView.contentOffset.y);


    } completion:^(BOOL finished) {
        [self addChildViewIntoScrollView:index];
    }];

}

/**
 添加第index处的按钮到scrollView
 */
- (void)addChildViewIntoScrollView: (NSInteger) index{
    UIView *childView = self.childViewControllers[index].view;

    if(childView.superview) return;

//    childView.frame = CGRectMake(index * YYhScreenW, 0, YYhScreenW, YYHScreenH);
    childView.frame = self.scrollView.bounds;

    [self.scrollView addSubview:childView];
}
- (void)configureBarButtonItem{
    self.view.backgroundColor = [UIColor magentaColor];
    //    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [leftButton setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
    //    [leftButton setImage:[UIImage imageNamed:@"nav_item_game_click_iconN"] forState:UIControlStateHighlighted];
    //    [leftButton addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    //    [leftButton sizeToFit];
    //    UIView *leftView = [[UIView alloc] initWithFrame:leftButton.frame];
    //    [leftView addSubview:leftButton];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"nav_item_game_icon"]  hightligtedImage:[UIImage imageNamed:@"nav_item_game_click_iconN"] Target:self action:@selector(game)];

    //可以使用同样的方法设置右边的rightBarButtonItem, 但是重复的代码太多, 而且之后的子控制器中也会有很多重复的的代码, 可以考虑抽取方法.

    //    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [rightButton setImage:[UIImage imageNamed:@"navigationButtonRandom"] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"navigationButtonRandomClick"] forState:UIControlStateHighlighted];
    //    [rightButton addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
    //    [rightButton sizeToFit];
    //    UIView *rightView = [[UIView alloc] initWithFrame:rightButton.frame];
    //    [rightView addSubview:rightButton];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"navigationButtonRandom"] hightligtedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] Target:self action:@selector(game)];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];


}
- (UIBarButtonItem *)barButtonWithImage:(UIImage *)image hightligtedImage:(UIImage *) highlightedImage Target:(nullable id)target action:(SEL)action{

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];
    UIView *leftView = [[UIView alloc] initWithFrame:leftButton.frame];
    [leftView addSubview:leftButton];
    return [[UIBarButtonItem alloc] initWithCustomView:leftView];

}
- (void)game{
    NSLog(@"游戏");
}

@end
