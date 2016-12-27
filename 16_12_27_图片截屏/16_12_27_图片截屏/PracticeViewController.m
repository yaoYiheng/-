//
//  PracticeViewController.m
//  16_12_27_图片截屏
//
//  Created by 姚懿恒 on 2016/12/28.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "PracticeViewController.h"

@interface PracticeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 起始点*/
@property (nonatomic, assign) CGPoint startPoint;
/** 覆盖的view*/
@property (nonatomic, weak) UIView *coverView;

@end

@implementation PracticeViewController

- (UIView *)coverView{
    if (!_coverView) {
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor lightGrayColor];
        cover.alpha = 0.7;
        [self.view addSubview:cover];
        _coverView = cover;
    }
    return _coverView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //为imageView添加手势

    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.imageView addGestureRecognizer:panGes];
    

}

- (void)panGes:(UIPanGestureRecognizer *)panGesture{
    //拿到手指当前点

    CGPoint currentPoint = [panGesture locationInView:self.imageView];

    if (panGesture.state == UIGestureRecognizerStateBegan) {
        self.startPoint = currentPoint;
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged){
        //在这里计算覆盖面积大小.
        CGRect coverRect = CGRectMake(self.startPoint.x, self.startPoint.y, currentPoint.x - self.startPoint.x, currentPoint.y - self.startPoint.y);
        self.coverView.frame = coverRect;

    }
    else if (panGesture.state == UIGestureRecognizerStateEnded){
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size, NO, 0.0);

        //获取当前位图上下文
        CGContextRef currentContext = UIGraphicsGetCurrentContext();

        //创建截图路径
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:self.coverView.frame];
        [clipPath addClip];

        //渲染到当前上下文
        [self.imageView.layer renderInContext:currentContext];
        //获取
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭图形上下文
        UIGraphicsEndImageContext();

        self.imageView.image = newImage;

        //移除覆盖
        [self.coverView removeFromSuperview];

    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
