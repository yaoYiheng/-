//
//  YYHHallTableViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHHallTableViewController.h"
#import "UIImage+WithoutRendering.h"
#import "YYHCover.h"
#import "YYHPopMenuView.h"

@interface YYHHallTableViewController () <YYHPopMenuViewDelegate>

@end

@implementation YYHHallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoutRendering:@"CS50_activity_image"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonOnClick)];



}
- (void)leftBarButtonOnClick{
    //弹出蒙板
    [YYHCover show];


    YYHPopMenuView *popMenu = [YYHPopMenuView showAtPoint:self.view.center];
    NSLog(@"%@", popMenu);

#warning 真他么奇怪, 无法设置代理属性?
//    popMenu.delegate = self;
   


    
}

#pragma mark YYHPopMenuViewDelegate代理
- (void)popMenuViewDidClickOnCloseButton:(YYHPopMenuView *)popMenuView{
//
//    //点击了关闭按钮后
//    [popMenuView disapperAtPoint:CGPointMake(0, 0)];
}


@end
