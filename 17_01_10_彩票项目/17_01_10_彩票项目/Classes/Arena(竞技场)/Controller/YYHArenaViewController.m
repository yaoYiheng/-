//
//  YYHArenaViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHArenaViewController.h"

@interface YYHArenaViewController ()

@end

@implementation YYHArenaViewController

//1.什么时候被调用？

//每次访问UIViewController的view(比如controller.view、self.view)而且view为nil，loadView方法就会被调用。

//2.有什么作用？

//loadView方法是用来负责创建UIViewController的view

//提高性能, 直接将自定义的imageView返回给控制器的view
- (void)loadView{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];

    imageView.image = [UIImage imageWithoutRendering:@"NLArenaBackground"];

    //设置能与用户交互
    imageView.userInteractionEnabled = YES;

    self.view = imageView;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载segmentControl
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"足球", @"篮球"]];
    self.navigationItem.titleView = segmentControl;

    [segmentControl setSelectedSegmentIndex:0];

    [segmentControl setTitleTextAttributes:@{
                                                NSFontAttributeName : [UIFont systemFontOfSize:15],
                                                NSForegroundColorAttributeName: [UIColor whiteColor]
                                                } forState:UIControlStateNormal];

    segmentControl.tintColor = [UIColor colorWithRed:0 green:142/255.0f blue:143/255.0f alpha:1];

    //设置segmentControl背景图片.
    [segmentControl setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    [segmentControl setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
