//
//  YYHEssenceViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

/*
    设置导航条上的按钮.
        问题: 设置完成后, 点击按钮周围区域, 也会显示高亮状态.
        分析: 是否是因为图片过大? 不是.
        解决: 将按钮添加到UIView中, 在将UIView作为自定义View添加到leftBarButtonItem中
 */
#import "YYHEssenceViewController.h"
#import "YYHTitleButton.h"

@interface YYHEssenceViewController ()
/** <#comments#>*/
@property (nonatomic, weak) UIView *titleView;
/** <#comments#>*/
@property (nonatomic, weak) UIButton *selectedButton;
/** <#comments#>*/
@property (nonatomic, weak) UIView *underLine;

@end

@implementation YYHEssenceViewController

#pragma mark -----view生命周期方法-----
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏按钮
    [self configureBarButtonItem];

    //添加scrollView

    [self configureScrollView];

    //添加标题栏
    [self configureTitleView];

}
#pragma mark -----初始化子控件-----
/**
 设置ScrollView
 */
- (void)configureScrollView{
    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor cyanColor];

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
    CGFloat titleViewH = 40;
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


        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.titleView addSubview:titleButton];
    }

}

- (void)titleButtonClick: (YYHTitleButton *)titleButton{
    YYHFunc
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;

    self.underLine.backgroundColor = [titleButton currentTitleColor];

    //点击按钮时, 移动下划线的位置
    [UIView animateWithDuration:0.2 animations:^{
        self.underLine.yyh_width = titleButton.titleLabel.yyh_width;
        self.underLine.yyh_centerX = titleButton.yyh_centerX;
    }];

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
