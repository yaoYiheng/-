//
//  YHImageView.m
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2017/1/1.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YHImageView.h"

@interface YHImageView ()<UIGestureRecognizerDelegate>

/** View中的UIImageView*/
@property (nonatomic, weak) UIImageView *hiddenImageView;

@end

@implementation YHImageView

- (UIImageView *)hiddenImageView{
    if (_hiddenImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = self.frame;
        _hiddenImageView = imageView;
        [self addSubview:imageView];
        [self addGestureForHiddenImageView];

    }
    return _hiddenImageView;
}
- (void)setPassedImage:(UIImage *)passedImage{
    _passedImage = passedImage;
    self.hiddenImageView.image = passedImage;
}

#pragma mark -为IM个View添加手势
- (void)addGestureForHiddenImageView{
    //添加拖拽手势
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.hiddenImageView addGestureRecognizer:panGes];

    //添加旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGes:)];

    //实现多重手势
    rotationGesture.delegate = self;
    [self.hiddenImageView addGestureRecognizer:rotationGesture];

    //添加捏合手势
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGes:)];
    pinchGes.delegate = self;
    [self.hiddenImageView addGestureRecognizer:pinchGes];

    //添加长按手势
    UILongPressGestureRecognizer *longGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGes:)];
    [self.hiddenImageView addGestureRecognizer:longGest];




}

#pragma mark -实现手势方法

/**
 允许多重手势
例如:旋转的同时进行缩放
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture{
    CGPoint transPoint = [panGesture translationInView:panGesture.view];

    panGesture.view.transform = CGAffineTransformTranslate(panGesture.view.transform, transPoint.x, transPoint.y);
    [panGesture setTranslation:CGPointZero inView:panGesture.view];

}

- (void)rotationGes:(UIRotationGestureRecognizer *)rotationGes{

    rotationGes.view.transform = CGAffineTransformRotate(rotationGes.view.transform, rotationGes.rotation);
    //旋转进行复位
    rotationGes.rotation = 0;

}

- (void)pinGes:(UIPinchGestureRecognizer *)pinGes{

    pinGes.view.transform = CGAffineTransformScale(pinGes.view.transform, pinGes.scale, pinGes.scale);
    pinGes.scale = 1;
}

/**
 长按时, 将从相册中加载的图片绘制到画板上
 */
- (void)longPressGes:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        //先实现长按后, 图片闪烁效果
        [UIView animateWithDuration:0.2 animations:^{

            self.hiddenImageView.alpha = 0;

        } completion:^(BOOL finished) {

            [UIView animateWithDuration:0.1 animations:^{

                self.hiddenImageView.alpha = 1;

            } completion:^(BOOL finished) {
                //将当前的图片进行截屏操作
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);

                CGContextRef currentContext = UIGraphicsGetCurrentContext();

                [self.layer renderInContext:currentContext];

                //获取新图片
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

                //关闭图形上下文
                UIGraphicsEndImageContext();

                //调用代理方法, 将新生成的图片传递给实现了代理方法的对象

                /**
                 注意点:需要self.delegate 实现了该方法, 而不是self.
                 */
                if ([self.delegate respondsToSelector:@selector(YHImageView:image:)]) {
                    [self.delegate YHImageView:self image:newImage];


                    //从父控件当中移除
                    [self removeFromSuperview];
                }

            }];
        }];
    }

}
@end
