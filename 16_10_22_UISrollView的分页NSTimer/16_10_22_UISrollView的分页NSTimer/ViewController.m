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



    
}
#pragma mark 定时器相关代码
//开始定时器
-(void)startAuto{
   self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startAuto];
}

@end
