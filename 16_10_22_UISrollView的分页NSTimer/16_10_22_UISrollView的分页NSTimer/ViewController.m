//
//  ViewController.m
//  16_10_22_UISrollView的分页NSTimer
//
//  Created by 姚懿恒 on 2016/10/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/** Timer*/
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat scrollViewWidth = self.scorllView.frame.size.width;
    CGFloat scrollViewHeight = self.scorllView.frame.size.height;
    for (int i = 1; i <7; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewWidth * (i- 1), 0, scrollViewWidth, scrollViewHeight)];
        imageView.image = image;

        [self.scorllView addSubview:imageView];

    }
    self.scorllView.pagingEnabled = YES;
    self.scorllView.contentSize = CGSizeMake(6*scrollViewWidth, 0);


    [self startAuto];

    
}



/**
 线程:
 主线程:程序一启动, 系统会默认创建一条线程, 作用:显示刷新UI界面, 处理与用户的交互事件

 */
#pragma mark 定时器相关代码
//开始定时器
-(void)startAuto{
    //该方法会返回一个自动执行的定时器对象.
   self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];


    //如果不加以下代码, 在执行别的操作时, 定时器便会停止自动加载, 为解决这个问题采用以下代码
    /*
     NSDefaultRunLoopMode(默认):同一时间只能执行一个任务
     NSRunLoopCommonModes(公用):可分配一定的时间执行其他任务 
     */
    //修改timer在runLoop中的模式为NSRunLoopCommonModes
    //目的:无论主线程在做什么操作, 都会分配一定时间处理定时器.
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}
//停止定时器
-(void)stopAuto{
    [self.timer invalidate];
}
-(void)nextPage{
    NSInteger nextPage = self.pageControl.currentPage + 1;

    if (nextPage == 6) {
        nextPage = 0;
    }
    [self.scorllView setContentOffset:CGPointMake(nextPage * _scorllView.frame.size.width, 0) animated:YES];


}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger page = (self.scorllView.contentOffset.x / self.scorllView.frame.size.width) + 0.5;
    self.pageControl.currentPage = page;
}

/**
 当用户开始拖拽时, 便停止自动播放功能.
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopAuto];
}

/**
 当用户停止拖拽时, 开启自动播放功能

 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startAuto];
}

@end
