//
//  YYHHallTableViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHHallTableViewController.h"
#import "UIImage+WithoutRendering.h"

@interface YYHHallTableViewController ()

@end

@implementation YYHHallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoutRendering:@"CS50_activity_image"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonOnClick)];



}
- (void)leftBarButtonOnClick{
    
}



@end
