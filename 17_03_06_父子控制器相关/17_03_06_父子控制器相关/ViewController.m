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


/**
 占位视图
    UITabBarController有个专门存放子控制器view,
 占位视图思想:
    1.不用去考虑子控制器的view尺寸
    2.屏幕适配也不用管理
 */
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self configureChildrenViewController];
    [self setTitile];


}

/**
 添加所有子控制器
 */
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

/**
 设置对应按钮内容, 按钮内容有子控制器决定
 */
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
     从contentView中遍历所有元素, 然后移除
     */
    //makeObjectsPerformSelector调用该方法,会遍历数组中每一个元素, 并对每一个元素都执行提供的方法
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];


    //添加对应的控制器的view到contentView中
    UIViewController *vc = self.childViewControllers[sender.tag];
    vc.view.backgroundColor = [sender backgroundColor];
    vc.view.frame = self.contentView.bounds;

    [self.contentView addSubview:vc.view];
}


@end
