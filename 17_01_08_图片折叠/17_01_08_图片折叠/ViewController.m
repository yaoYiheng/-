//
//  ViewController.m
//  17_01_08_图片折叠
//
//  Created by 姚懿恒 on 2017/1/8.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttomImageView;
/** <#comments#>*/
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     修改 layer的contentsRect属性, 可以设置图片显示的范围, 并会填充至图片之前大小.
     
     */
    self.topImageView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.buttomImageView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);

    self.topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.buttomImageView.layer.anchorPoint = CGPointMake(0.5, 0);

    //为图层添加渐变层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //设置渐变颜色
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    //渐变区域
    gradientLayer.frame = self.buttomImageView.bounds;
    //渐变透明度, 1 为不透明
    gradientLayer.opacity = 0;


    //设置渐变的方向
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
    //设置一个渐变到另一个渐变的起始位置
//    gradientLayer.locations = @[@0.4, @0.7];

    [self.buttomImageView.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {

    CGPoint offset = [sender translationInView:sender.view];

    //当偏移量最大等于 手势能拖动的距离时, 角度最大为180 M_PI.
    CGFloat angle = offset.y * M_PI / 256;

    //获取3dtransform
    CATransform3D transform = CATransform3DIdentity;

    //transform中的M34值, 修改该值可以实现近大远小的效果.
    //分子为-1, 分母越大表示眼睛距离屏幕越远
    transform.m34 = -1 / 300;

//    self.topImageView.layer.transform = CATransform3DMakeRotation(-angle, 1, 0, 0);

    self.topImageView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);

    self.gradientLayer.opacity = offset.y * 1 / 256;

    if (sender.state == UIGestureRecognizerStateEnded) {

        self.gradientLayer.opacity = NO;

        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveLinear animations:^{

            self.topImageView.layer.transform = CATransform3DIdentity;

        } completion:^(BOOL finished) {
        }];
    }

}


@end
