//
//  YHAutoScrollView.m
//  16_10_23_AutoScrollView的封装
//
//  Created by 姚懿恒 on 2016/10/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHAutoScrollView.h"

@interface YHAutoScrollView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** NSTimer*/
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation YHAutoScrollView

+(instancetype)autoScrollView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self startAuto];

}
-(void)setImageNames:(NSArray *)imageNames{
    _imageNames = imageNames;

    //1.根据传入的图片名创建ImageView并添加到scrollView中
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGFloat scrollViewHeight = self.scrollView.frame.size.height;
    NSInteger count = imageNames.count;
    for (int i = 0; i <count; i++) {
        NSString *imageName = imageNames[i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewWidth * i, 0, scrollViewWidth, scrollViewHeight)];
        imageView.image = image;

        [self.scrollView addSubview:imageView];

    }
    self.pageView.numberOfPages = count;
    self.scrollView.contentSize = CGSizeMake(count * scrollViewWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    self.pageView.currentPage = page;
}
-(void)startAuto{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stopAuto{
    [self.timer invalidate];
}
-(void)nextPage{
    NSInteger nextPage = self.pageView.currentPage + 1;
    self.pageView.currentPage = nextPage;
    if (nextPage == self.imageNames.count) {
        nextPage = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(nextPage * self.scrollView.bounds.size.width, 0) animated:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopAuto];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self startAuto];
}
@end

