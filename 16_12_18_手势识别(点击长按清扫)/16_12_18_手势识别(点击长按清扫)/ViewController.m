//
//  ViewController.m
//  16_12_18_手势识别(点击长按清扫)
//
//  Created by 姚懿恒 on 2016/12/18.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpRotationGes];

    [self setUpPinch];
}
#pragma mark 代理方法, 运行同时多种手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
#pragma mark 设置旋转手势
- (void)setUpRotationGes{
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGes:)];
    [self.imageView addGestureRecognizer:rotationGes];
}
- (void)rotationGes:(UIRotationGestureRecognizer *)rotationGes{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotationGes.rotation);
    //为支持在多手势同时实现, 可使用代理方法
    rotationGes.delegate = self;
    [rotationGes setRotation:0];
}
#pragma mark 设置捏合手势
- (void)setUpPinch{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pitch:)];
    [self.imageView addGestureRecognizer:pinch];

}
- (void)pitch:(UIPinchGestureRecognizer *)pitch{
    //设置图片缩放
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pitch.scale, pitch.scale);
    //旋转的同时能够缩放
    pitch.delegate = self;
    //复位.
    [pitch setScale:1];

}
#pragma mark 设置轻扫
- (void)setUpSwip{
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
    [self.imageView addGestureRecognizer:swip];
}
- (void)swip:(UISwipeGestureRecognizer *)swip{
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    NSLog(@"%s", __func__);
}
#pragma mark 设置长按
- (void)setUpLongPress{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
        [self.imageView addGestureRecognizer:longPress];
}
- (void)longPress:(UILongPressGestureRecognizer *)longPress{


}

- (void)setUpTap{
    //1.创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //2.将手势添加到想要实现的子控件上
    [self.imageView addGestureRecognizer:tap];

}

//3.实现手势方法
- (void)tap{
    NSLog(@"%s",__func__);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpPan{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
}
#pragma mark 设置拖拽手势.
- (void)pan:(UIPanGestureRecognizer *)pan{

    CGPoint translationPoint = [pan translationInView:self.imageView];
    //
    [pan setTranslation:CGPointZero inView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform,translationPoint.x , translationPoint.y);


    NSLog(@"%@",NSStringFromCGPoint(translationPoint));
}

@end
