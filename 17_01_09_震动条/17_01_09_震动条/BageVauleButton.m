//
//  BageVauleButton.m
//  17_01_09_震动条
//
//  Created by 姚懿恒 on 2017/1/9.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "BageVauleButton.h"

@interface BageVauleButton()


/** 红色小view*/
@property (nonatomic, weak) UIView *littleCircle;
/** 可通过过形状图层添加.
 形状图层会根据一个路径生成一个形状.*/
@property (nonatomic, weak) CAShapeLayer *shapeLayer;

@end

@implementation BageVauleButton


#pragma mark -懒加载形状图层
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        //将形状图层添加到父控件, 最接近父曾的位置
        [self.superview.layer insertSublayer:shapeLayer atIndex:0];
        //设置填充色
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        //为成员变量赋值
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}
- (void)awakeFromNib{
    [super awakeFromNib];

    [self configureButton];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureButton];
    }
    return self;
}
- (void)configureButton{

    self.layer.cornerRadius = self.bounds.size.width / 2;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    UIView *littleCircle = [[UIView alloc] init];
    littleCircle.frame = self.frame;
    littleCircle.layer.cornerRadius = self.layer.cornerRadius;
    littleCircle.backgroundColor = [UIColor redColor];
    //将小圆添加到父控件
    [self.superview addSubview:littleCircle];
    //将小圆插入到 按钮之下
    [self.superview insertSubview:littleCircle belowSubview:self];

    self.littleCircle = littleCircle;


    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:pan];

}

/**
 手势拖动时, 计算两个控件之间的距离, 并根据距离缩放小圆

 */
- (void)panGesture:(UIPanGestureRecognizer *)panGes{

    CGPoint currentPoint = [panGes translationInView:self];
    CGPoint center = self.center;
    center.x += currentPoint.x;
    center.y += currentPoint.y;
    self.center = center;
    [panGes setTranslation:CGPointZero inView:self];

    //计算出两个view之间的距离
    CGFloat distance = [self distanceBetweenView:self.littleCircle AndView:self];

    //取出小圆的半径 == 按钮的半径的一半,
    CGFloat littleRadius = self.bounds.size.width / 2;

    //小圆的半径跟随距离的增大而减小
    littleRadius -= distance / 5;


    //重新设置小圆的bounds
    self.littleCircle.bounds = CGRectMake(0, 0, littleRadius * 2, littleRadius * 2);
    //同时设置小圆的圆角半径
    self.littleCircle.layer.cornerRadius = littleRadius;

    //当小圆的没有隐藏时, 才需要重绘不规则路径.
    if (!self.littleCircle.hidden) {
        self.shapeLayer.path = [self pathForBetweenView:self.littleCircle AndView:self].CGPath;

    }


    //距离大于60时, 隐藏小圆并移除添加的不规则图形
    if (distance > 60) {
        self.littleCircle.hidden = YES;
        [self.shapeLayer removeFromSuperlayer];
    }
    if (panGes.state == UIGestureRecognizerStateEnded) {
        //当手指离开屏幕时, 如果两个之间的距离小于60, 则按钮回到原来位置
        if (distance < 60) {
            [self.shapeLayer removeFromSuperlayer];
            self.center = self.littleCircle.center;
            self.littleCircle.hidden = NO;
        }
        //距离大于60, 按钮消失
        else
        {

            /**
             可做一下消失时的动画.
             
             */


        }

    }


}
#pragma mark  通过给定的两个view 计算两个view之间的距离
- (CGFloat)distanceBetweenView:(UIView*) viewOne AndView:(UIView *)viewTwo{

    CGPoint centerOne = viewOne.center;
    CGPoint centerTwo = viewTwo.center;



    CGFloat offsetX = centerTwo.x - centerOne.x;
    CGFloat offsetY = centerTwo.y - centerOne.y;

    return sqrt(offsetX * offsetX + offsetY * offsetY);

}

#pragma mark -通过给定两个圆, 返回不规则路径
- (UIBezierPath *)pathForBetweenView:(UIView*) littleCircle AndView:(UIView *)bigCircle{

    CGFloat x1 = littleCircle.center.x;
    CGFloat y1 = littleCircle.center.y;

    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;

    CGFloat distance = [self distanceBetweenView:littleCircle AndView:bigCircle];

    if (distance <= 0) {
        return nil;
    }

    CGFloat cosθ = (y2 - y1) / distance;
    CGFloat sinθ = (x2 - x1) / distance;

    CGFloat littleCircleR = littleCircle.bounds.size.width / 2;
    CGFloat bigCircleR = bigCircle.bounds.size.width / 2;

    CGPoint pointA = CGPointMake(x1 - littleCircleR * cosθ, y1 + littleCircleR * sinθ);
    CGPoint pointB = CGPointMake(x1 + littleCircleR * cosθ, y1 - littleCircleR * sinθ);
    CGPoint pointC = CGPointMake(x2 + bigCircleR * cosθ, y2 - bigCircleR * sinθ);
    CGPoint pointD = CGPointMake(x2 - bigCircleR * cosθ, y2 + bigCircleR * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + distance * 0.5 * sinθ, pointA.y + distance * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + distance * 0.5 * sinθ, pointB.y + distance * 0.5 * cosθ);


    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];

    return path;

}
#pragma mark - 重写该方法, 使按钮点击时高亮无反应
- (void)setHighlighted:(BOOL)highlighted{

}
@end
