//
//  ViewController.m
//  17_03_10_UIScrollView简单实现
//
//  Created by 姚懿恒 on 2017/3/9.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, weak) UIView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 模仿系统控件 => 怎么去使用 => 滚动scrollView,其实本质滚动内容 => 改bounds => 验证

    // => 手指往上拖动,bounds y++ ,内容才会往上走
    UIView *scrollView = [[UIView alloc] initWithFrame:self.view.bounds];

    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(130, 130, 120, 120)];
    //添加手势

    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [scrollView addGestureRecognizer:panGest];

    [scrollView addSubview:switchView];

    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

}
- (void)panGesture:(UIPanGestureRecognizer *)pan{

     CGPoint transPoint = [pan translationInView:pan.view];

    CGRect bounds = self.scrollView.bounds;
    bounds.origin.y -= transPoint.y;

    self.scrollView.bounds = bounds;

    [pan setTranslation:CGPointZero inView:pan.view];

    NSLog(@"%@", NSStringFromCGPoint(transPoint));
}



@end
