//
//  YHDrawerViewController.m
//  16_12_20_抽屉效果
//
//  Created by 姚懿恒 on 2016/12/20.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHDrawerViewController.h"
#define MaxY 100
#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define targetR 320
#define targetL -320

@interface YHDrawerViewController ()
/** 红色view*/
@property (nonatomic, weak) UIView *redView;
/** 蓝色view*/
@property (nonatomic, weak) UIView *blueView;
/** 绿色view*/
@property (nonatomic, weak) UIView *greenView;
@end

@implementation YHDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpView];
    [self setUpPanForRedView];

    //为控制器的view添加手势, 点击时使红色View复位
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];

    [self.view addGestureRecognizer:tapGes];

}
- (void)tap{
    [UIView animateWithDuration:0.3 animations:^{

        self.redView.frame = self.view.frame;
    }];
}
#pragma mark 创建加载所需要的view
- (void)setUpView{
    UIView *greenView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    greenView.backgroundColor = [UIColor greenColor];
    self.greenView = greenView;
    [self.view addSubview:greenView];

    UIView * blueView= [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    blueView.backgroundColor = [UIColor blueColor];
    self.blueView = blueView;
    [self.view addSubview:blueView];


    UIView *redView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self.view addSubview:redView];


}
#pragma mark 为红view设置拖拽手势.
- (void)setUpPanForRedView{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    [self.redView addGestureRecognizer:panGes];
}
- (void)panGes:(UIPanGestureRecognizer *) panGest{
    //返回偏移的点.
    CGPoint offsetPoint = [panGest translationInView:self.redView];
    self.redView.frame = [self frameWithOffsetX:offsetPoint.x];

    //每次赋值后归零
    [panGest setTranslation:CGPointZero inView:self.redView];
    //如果向右拖拽, 则隐藏蓝色view
    if (self.redView.frame.origin.x > 0) {
        self.blueView.hidden = YES;
    }else if (self.redView.frame.origin.x < 0){
        self.blueView.hidden = NO;
    }
    //初始化目标值
    CGFloat target = 0;
    //当停止拖拽时, 判断红色view的x值
    if (panGest.state == UIGestureRecognizerStateEnded) {
        if (self.redView.frame.origin.x > screenW * 0.5) {
            target = targetR;
        }
        else if(CGRectGetMaxX(self.redView.frame) < screenW * 0.5 ){
            target = targetL;
        }
        //求出目标距离与当前x值的offset, 调用frameWithOffsetX:方法求出对应的frame
        CGFloat offset = target - self.redView.frame.origin.x;
        [UIView animateWithDuration:0.3 animations:^{

            self.redView.frame = [self frameWithOffsetX:offset];

        }];
    }



}
- (CGRect)frameWithOffsetX:(CGFloat) offsetX{

    CGRect redFrame = self.redView.frame;
    redFrame.origin.x += offsetX;

    redFrame.origin.y = fabs(redFrame.origin.x * MaxY / screenW);
    redFrame.size.height = screenH - 2 * redFrame.origin.y;
    return redFrame;
}


@end
