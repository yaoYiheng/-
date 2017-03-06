//
//  ViewController.m
//  17_03_06_父子控制器相关
//
//  Created by 姚懿恒 on 2017/3/6.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "BlueViewController.h"
#import "RedViewController.h"
#import "OrangeViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self configureChildrenViewController];
    [self setTitile];


}

- (void)configureChildrenViewController{

    BlueViewController *blueVC = [BlueViewController new];
    blueVC.title = @"蓝色";
    [self addChildViewController:blueVC];

    OrangeViewController *orangeVC = [OrangeViewController new];
    orangeVC.title = @"橙色";
    [self addChildViewController:orangeVC];

    RedViewController *redVC = [RedViewController new];
    redVC.title = @"红色";
    [self addChildViewController:redVC];

}

- (void)setTitile{
    NSInteger count = self.buttonView.subviews.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.buttonView.subviews[i];
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];

    }
}
- (IBAction)buttonClick:(UIButton *)sender {

    //从contentView中移除子控制器的view
    /*
     makeObjectsPerformSelector: 调用该方法会变量数组中的每一个元素, 并执行所给出的方法
     */
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    //添加对应的控制器的view到contentView中
    UIViewController *vc = self.childViewControllers[sender.tag];
    vc.view.backgroundColor = [sender backgroundColor];
    vc.view.frame = self.contentView.bounds;

    [self.contentView addSubview:vc.view];
}


@end
