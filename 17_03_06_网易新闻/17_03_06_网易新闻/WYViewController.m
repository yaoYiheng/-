//
//  WYViewController.m
//  17_03_06_网易新闻
//
//  Created by 姚懿恒 on 2017/3/8.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "WYViewController.h"
#import "TopLineViewController.h"
#import "HotViewController.h"
#import "VideoViewController.h"
#import "SocietyViewController.h"
#import "ReaderViewController.h"
#import "ScienceViewController.h"

/*
 为了达到代码的可重复利用, 做简单抽取.

 */

@interface WYViewController ()

@end

@implementation WYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //为了这段代码的可扩展性, 将该方法写入到子类的实现中.
    [self configureChildrenViewController];
}

-(void)configureChildrenViewController{
    //头条
    TopLineViewController *top = [TopLineViewController new];
    top.title = @"头条";
    [self addChildViewController:top];

    //热点
    HotViewController *hot = [HotViewController new];
    hot.title = @"热点";
    [self addChildViewController:hot];

    //视频
    VideoViewController *video = [VideoViewController new];
    video.title = @"视频";
    [self addChildViewController:video];

    //社会
    SocietyViewController *soci = [SocietyViewController new];
    soci.title = @"社会";
    [self addChildViewController:soci];

    //订阅
    ReaderViewController *reader = [ReaderViewController new];
    reader.title = @"订阅";
    [self addChildViewController:reader];

    //科技
    ScienceViewController *sci = [ScienceViewController new];
    sci.title = @"科技";
    [self addChildViewController:sci];
    
}

@end
