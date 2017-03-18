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

@interface YYHEssenceViewController ()

@end

@implementation YYHEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
