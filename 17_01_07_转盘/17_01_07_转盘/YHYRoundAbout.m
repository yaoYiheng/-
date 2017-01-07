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

@interface YHYRoundAbout ()


@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;

/** 选中的按钮*/
@property (nonatomic, weak) YHYButton *selectedButton;
@end

@implementation YHYRoundAbout

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

    self.rotateImageView.userInteractionEnabled = YES;

    CGFloat buttonW = 68;
    CGFloat buttonH = 143;
    CGFloat rotationAngle = 0;

    for (int i = 0; i < 12; i++) {
        YHYButton *button = [YHYButton buttonWithType:UIButtonTypeCustom];


        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"]  forState:UIControlStateSelected];

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

- (void)buttonClick:(YHYButton *)btn{
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
}
#pragma mark -旋转与停止旋转
- (void)startRotate{

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(M_PI * 2);
    animation.duration= 1;

    [self.rotateImageView.layer addAnimation:animation forKey:nil];

}
- (void)pause{
    
}



@end
