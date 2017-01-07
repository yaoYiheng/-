//
//  ViewController.m
//  17_01_05_CABasciAnimation
//
//  Created by 姚懿恒 on 2017/1/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

#define angleToRadio(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ginImageView;

@property (weak, nonatomic) IBOutlet UIImageView *universeImageView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ginImageView.layer.borderWidth = 8;
    self.ginImageView.layer.borderColor = [UIColor orangeColor].CGColor;
    //当控件的圆角半径大于控件宽度一半时, 会使控件呈现菱形.
    self.ginImageView.layer.cornerRadius = 90;

    self.ginImageView.layer.masksToBounds = YES;

//    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(350, 360, 4, 4)];
//    whiteView.backgroundColor = [UIColor redColor];
//    self.universeImageView.frame = CGRectMake(50, 360, 300, 287);
//    [whiteView addSubview:self.universeImageView];
//    [self.view addSubview:whiteView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -基础动画
- (void)loadBasicAnimation{
    //1. 创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];

    //    animation.keyPath = @"hidden";
    ////    animation.toValue = @YES;
    //
    //    animation.keyPath = @"backgroundColor";
    //    animation.toValue = [UIColor redColor];
    //    animation.keyPath = @"position.y";
    //    animation.toValue = @400;
    //
    //动画完成是是否移除动画
    //    animation.removedOnCompletion = NO;
    //完成后动画保持什么状态
    //    animation.fillMode = @"forwards";
    //
    //      将动画添加到需要实现动画的层
    //    [self.orangeView.layer addAnimation:animation forKey:nil];

    /**
     通过修改transform.scale, 实现心跳效果
     */
    animation.keyPath = @"transform.scale";
    animation.toValue = @(0.5);

    //动画执行时长
    animation.duration = 1;
    //动画重复次数
    animation.repeatCount = MAXFLOAT;
    //怎么去怎么样回
    animation.autoreverses = YES;
    [self.heartImageView.layer addAnimation:animation forKey:nil];

}
#pragma mark 帧动画
- (void)loadCAKeyframeAnimation{


    /**
     以下为帧动画 CAKeyframeAnimation


     用法1:可以传入多个动画效果值.
     KFAnimation.values = @[@angleToRadio(180), @angleToRadio(-180)];


     用法2:控件设置运行路径
     1. 创建动画对象
     2. 设置动画属性
     KFAnimation.keyPath = @"position"; (位置改变)
     3. 为控件添加移动路径
     UIBezierPath *path = [UIBezierPath bezierPath];
     [path moveToPoint:center];
     [path addLineToPoint:CGPointMake(0, 0)];

     KFAnimation.path = path.CGPath;


     注意: 想要为同一个控件添加多个动画, 比如旋转的同时进行移动, 需要创建两个动画对象, 并
     添加到需要设置动画的子控件上.

     */

    CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animation];
    //设置动画属性
    KFAnimation.keyPath = @"position";


    CGPoint center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);


    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addLineToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(370, 500)];

    KFAnimation.path = path.CGPath;


    KFAnimation.duration = 4;
    KFAnimation.autoreverses = YES;
    KFAnimation.repeatCount = MAXFLOAT;

    [self.ginImageView.layer addAnimation:KFAnimation forKey:nil];




    //旋转动画
    CAKeyframeAnimation *KFAnimation1 = [CAKeyframeAnimation animation];
    KFAnimation1.keyPath = @"transform.rotation";



    /**
     #define angleToRadio(angle) ((angle) / 180.0 * M_PI)

     翻转效果,将一个空间进行180°旋转后在进行-180°旋转,

     也可以设置控件抖动效果.

     */

    KFAnimation1.values = @[@angleToRadio(180), @angleToRadio(-180)];

    KFAnimation1.duration = 5;
    KFAnimation1.repeatCount = MAXFLOAT;

    [self.ginImageView.layer addAnimation:KFAnimation1 forKey:nil];

}
static int imageIndex = 1;

#pragma mark -转场动画
- (void)loadCATransition{

    /**
     转场动画与转场代码必须放在同一方法中
     
     */

    //转场代码
    imageIndex++;
    if (imageIndex == 7) {
        imageIndex = 1;
    }
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg", imageIndex];
    self.universeImageView.image = [UIImage imageNamed:imageName];




    CATransition *animation = [CATransition animation];
    /**
     camaraIrisHollowClose  相机镜头打开关闭效果
     camaraIrisHollowClose  相机镜头关闭效果
     pageCurl               向上翻页效果
     pageUnCurl             向下翻页效果
     rippleEffect           水滴效果      //有点炫酷
     suckEffect             抽桌布效果    //止点为父控件的(0, 0)点,
                                        //可以为其添加白色父控件达到控制收缩位置的效果
     oglFlip                上下左右翻转效果
     cube                   立方体翻转效果
     

     fade                   交叉淡化过度效果
     reveal                 移开旧视图,显示下面的视图
     moveIn                 将新视图移到旧视图之上
     push                   将旧视图推走

     */
    animation.type = @"push";
    animation.duration = 1;

    /**
     翻书效果.
     可改变翻书的起始点
     */
//    animation.startProgress = 0;
//    animation.endProgress = 1;

    [self.universeImageView.layer addAnimation:animation forKey:nil];
    


}
#pragma mark -组动画
- (void)loadGroupAnimation{
    /**
                   
     使用组动画的好处
     
     可以同时执行多个动画, 且不需要为给个动画设置结束时额属性,
     只需将需要执行的动画添加到 animations 数组中即可
     
     动画完成时的属性也可只设置一次.
                            
                       

    */
    CAAnimationGroup *group = [CAAnimationGroup animation];

    CABasicAnimation *ani1 = [CABasicAnimation animation];
    ani1.keyPath = @"position.y";
    ani1.toValue = @400;

    CABasicAnimation *ani2 = [CABasicAnimation animation];
    ani2.keyPath = @"transform.scale";
    ani2.toValue = @0.5;

    group.animations = @[ani1, ani2];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [self.orangeView.layer addAnimation:group forKey:nil];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self loadGroupAnimation];


}


@end
