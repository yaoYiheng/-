//
//  YHYRoundAbout.m
//  17_01_07_转盘
//
//  Created by 姚懿恒 on 2017/1/7.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YHYRoundAbout.h"
#import "YHYButton.h"

#define angleToRadio(angle) ((angle) / 180 * M_PI)

@interface YHYRoundAbout () <CAAnimationDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;

/** 选中的按钮*/
@property (nonatomic, weak) YHYButton *selectedButton;

/** 添加定时器*/
@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation YHYRoundAbout


#pragma mark -懒加载定时器
- (CADisplayLink *)link{
    if (!_link) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    return _link;
}

#pragma mark -初始化方法.
+(instancetype)roundAbout{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return self;
}

#pragma mark -添加按钮
- (void)awakeFromNib{
    [super awakeFromNib];
    //加载原始图片

    UIImage *originalImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *originalSelImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];

    self.rotateImageView.userInteractionEnabled = YES;

    CGFloat buttonW = 68;
    CGFloat buttonH = 143;
    CGFloat rotationAngle = 0;

    CGFloat photoRectX = 0;
    CGFloat photoRectY = 0;
    CGFloat photoRectW = originalImage.size.width / 12 * [UIScreen mainScreen].scale ;
    CGFloat photoRectH = originalImage.size.height * [UIScreen mainScreen].scale;

    CGRect photoRect;



    for (int i = 0; i < 12; i++) {
        YHYButton *button = [YHYButton buttonWithType:UIButtonTypeCustom];

        //设置选中状态下的背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"]  forState:UIControlStateSelected];


        photoRectX = photoRectW * i;
        photoRect = CGRectMake(photoRectX , photoRectY, photoRectW, photoRectH);


        //调用 CGImageCreateWithImageInRect 传入一张图片,以及裁剪区域的大小, 可以返回一张裁剪自原图的图片指针, 需要使用imageWithCGImage 将其转为 对象.

        //设置按钮正常状态下的图片

        CGImageRef clippedImage = CGImageCreateWithImageInRect(originalImage.CGImage, photoRect);
        [button setImage:[UIImage imageWithCGImage:clippedImage] forState:UIControlStateNormal];

        //设置按钮高亮下的状态
        CGImageRef clippedSelImage = CGImageCreateWithImageInRect(originalSelImage.CGImage, photoRect);

        [button setImage:[UIImage imageWithCGImage:clippedSelImage] forState:UIControlStateSelected];




        button.bounds = CGRectMake(0, 0, buttonW, buttonH);

        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = CGPointMake(self.rotateImageView.frame.size.width / 2, self.rotateImageView.frame.size.height /2);

        button.transform = CGAffineTransformMakeRotation(angleToRadio(rotationAngle));

        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.rotateImageView addSubview:button];

        rotationAngle += 30;

        if (i == 0) {
            [self buttonClick:button];
        }
    }



}

/**
 更改按钮的点击状态
 */
- (void)buttonClick:(YHYButton *)btn{
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
}
#pragma mark -旋转与停止旋转


/**
 直接调用link的paused 方法来开始或暂停动画
 */
- (void)startRotate{

    self.link.paused = NO;


}
- (void)pause{
    self.link.paused = YES;
}


/**
 不用核心动画, 而是cg动画完成旋转, 因为需要在旋转的过程中对转盘进行操作, 而核心动画只是假象.
 */
- (void)rotate{
    self.rotateImageView.transform = CGAffineTransformRotate(self.rotateImageView.transform, M_PI / 180);
}

/**
 快速旋转, 用户不能点击, 所以可用使用核心动画完成此功能

 */
- (IBAction)startChoosing:(UIButton *)sender {

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(M_PI * 8);
    animation.duration= 1;
    animation.delegate = self;

    [self.rotateImageView.layer addAnimation:animation forKey:nil];
}
#pragma mark -CAAnimationDelegate代理方法, 核心动画结束后调用.
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    /**
     可以通过获取控件的transform属性, 在调用atan2(transform.b, transform.a)方法, 可以获取控件当前旋转的角度
    */
    CGAffineTransform transform = self.selectedButton.transform;
    CGFloat angle = atan2(transform.b, transform.a);

    //使按钮的父控件倒转所选时的角度, 完成在最上面显示
    self.rotateImageView.transform =  CGAffineTransformMakeRotation(-angle);
}
@end
