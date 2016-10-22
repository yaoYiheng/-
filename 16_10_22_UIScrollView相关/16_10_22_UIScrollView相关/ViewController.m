//
//  ViewController.m
//  16_10_22_UIScrollView相关
//
//  Created by 姚懿恒 on 2016/10/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//
/*
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView;                                               // any offset changes
 - (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2); // any zoom scale changes

 // called on start of dragging (may require some time and or distance to move)
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
 // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
 - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
 // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

 - (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;   // called on finger up as we are moving
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt

 
 */

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img = [UIImage imageNamed:@"3.jpg"];
    UIImageView *image = [[UIImageView alloc] initWithImage:img];
    
    self.scrollView.contentSize = img.size;
    self.scrollView.pagingEnabled = YES;
    [self.scrollView addSubview:image];
}

/**
 当scrollView滚动时就会调用该方法, 无论是手动还是惯性
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll被调用了");
 
}

/**
 只有当减速完成后, 才会调用该方法

 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     NSLog(@"scrollViewDidEndDecelerating被调用了");
}

/**
 只要一开始被拖拽就会调用该方法

 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging被调用了");

}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndScrollingAnimation被调用了");
}
// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
    if (decelerate) {
        NSLog(@"decelerate");
    }else{
        NSLog(@"no decelerate");
    }
    CGPoint point=scrollView.contentOffset;
    NSLog(@"%f,%f",point.x,point.y);

}

@end
