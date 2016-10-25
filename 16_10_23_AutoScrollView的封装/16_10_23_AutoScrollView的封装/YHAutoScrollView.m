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

    /*
     设置scrollView自动适配屏幕位置, 该autoresizingMask设置一次即可, 在awakeFromNib中设置.
     设置scrollView的宽度与高度跟随父控件的尺寸进行伸缩

     //距离父控件的 ⬅️➡️⬆️⬇️ 是可伸缩的.
     UIViewAutoresizingFlexibleLeftMargin
     UIViewAutoresizingFlexibleRightMargin
     UIViewAutoresizingFlexibleTopMargin
     UIViewAutoresizingFlexibleBottomMargin

     //该方法设置子控件跟随父控件的宽高进行伸缩.
     UIViewAutoresizingFlexibleHeight
     UIViewAutoresizingFlexibleWidth
     */

    //设置scrollView的宽高跟随父控件的宽高进行伸缩.
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    //设置pageControl始终保持在右下部.
    self.pageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
}

/*
 layoutSubviews
 这个方法，默认没有做任何事情，需要子类进行重写 。 系统在很多时候会去调用这个方法：

 1.初始化不会触发layoutSubviews，但是如果设置了不为CGRectZero的frame的时候就会触发。
 2.addSubview会触发layoutSubviews
 3.设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4.滚动一个UIScrollView会触发layoutSubviews
 5.旋转Screen会触发父UIView上的layoutSubviews事件
 6.改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件

 在苹果的官方文档中强调: You should override this method only if the autoresizing behaviors of the subviews do not offer the behavior you want.layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。反过来的意思就是说：如果你想要在外部设置subviews的位置，就不要重写。
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    //根据 新传入的scrollView的frame来设置imageView的X值

    //遍历scrollView中的每一个imageView, 设置其x.
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGRect tempFrame = imageView.frame;
        tempFrame.origin.x = self.scrollView.frame.size.width * i;
        imageView.frame = tempFrame;
    }

}

-(void)setImageNames:(NSArray *)imageNames{
    _imageNames = imageNames;

    //0.移除之前添加的
    //让subviews这个数组中的每一个对象都执行removeFromSuperview
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //1.根据传入的图片名创建ImageView并添加到scrollView中
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGFloat scrollViewHeight = self.scrollView.frame.size.height;

    NSInteger count = imageNames.count;
    
    for (int i = 0; i <count; i++) {

        UIImage *image = [UIImage imageNamed:imageNames[i]];
        UIImageView *imageView = [[UIImageView alloc] init];
        //imageView的高度与宽度需要跟随父控件的高度与宽度进行伸缩.
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.frame = CGRectMake(scrollViewWidth * i, 0, scrollViewWidth, scrollViewHeight);
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

#pragma mark 计时器相关方法
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

