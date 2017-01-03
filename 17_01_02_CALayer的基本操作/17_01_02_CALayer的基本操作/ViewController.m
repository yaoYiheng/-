//
//  ViewController.m
//  17_01_02_CALayer的基本操作
//
//  Created by 姚懿恒 on 2017/1/2.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 自创建的calyer*/
@property (nonatomic, weak) CALayer *myLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 200, 200);
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.myLayer = layer;




    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tapOnImageView:(UITapGestureRecognizer *)sender {
    /**这些都是直接设置到imageView 的layer层上的, 而图片是显示在layer的contents属性上, 
     所以当设置圆角半径时, 图片不会有任何裁剪, 而想要对图片也进行圆角设置,
     需要改变masksToBounds = yes;
     */
    self.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.imageView.layer.borderWidth = 5;
    self.imageView.layer.cornerRadius = 50;

    //是否裁剪超过根层意外的东西.
    self.imageView.layer.masksToBounds = YES;

    [UIView animateWithDuration:1 animations:^{
        //在旋转的基础上再做旋转

        /**
         CATransform3D 3D操作.
         哪个参数为1, 绕着哪个轴旋转.
         */
        self.imageView.layer.transform = CATransform3DRotate(self.imageView.layer.transform, M_PI , 1, 1, 1);

    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 animations:^{

//           self.imageView.layer.transform = CATransform3DScale(self.imageView.layer.transform, 0.5, 0.5, 1.2);

           [self.imageView.layer setValue:@(M_PI) forKeyPath:@"transform.rotation"];
       }];
    }];

}

- (IBAction)tapOnGrayView:(UITapGestureRecognizer *)sender {

    //注意:这里添加的边框宽度并不是在原view的基础上添加10的宽度, 而是减少原view的宽度
    self.grayView.layer.borderWidth = 10;
    //设置边框颜色
    self.grayView.layer.borderColor = [UIColor orangeColor].CGColor;

    //设置阴影的模糊半径
    self.grayView.layer.shadowRadius = 10;

    //设置阴影偏移量
    self.grayView.layer.shadowOffset = CGSizeMake(10, 10);
    //设置阴影透明度, 取值范围0-1, 0为透明.
    self.grayView.layer.shadowOpacity = 1;
    //设置阴影颜色
    self.grayView.layer.shadowColor = [UIColor blackColor].CGColor;

    //设置圆角半径
    self.grayView.layer.cornerRadius = 20;
    [UIView animateWithDuration:1 animations:^{
        self.grayView.layer.transform = CATransform3DScale(self.grayView.layer.transform, 1, 2, 1);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    /**
 
     隐式动画:
     UIView内部自动关联的layer为根层
     自己创建的layer为非根层, 只有非根层才有隐式动画
     
     所谓隐式动画就是对可 动画的属性进行修改时, 自动产生的动画效果.
     常见的可以动画的属性有bounds backgroundColor position
 
 
     */

    //开启事物
    [CATransaction begin];
    //设置是否需要动画
    [CATransaction setDisableActions:NO];
    //设置动画持续时间
    [CATransaction setAnimationDuration:2];

    self.myLayer.bounds = CGRectMake(100, 100, 200, 200);
    self.myLayer.backgroundColor = [UIColor redColor].CGColor;
    self.myLayer.position = CGPointZero;

    //提交事物
    [CATransaction commit];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
