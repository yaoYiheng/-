//
//  UnlockView.m
//  16_12_29_手势解锁
//
//  Created by 姚懿恒 on 2016/12/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "UnlockView.h"


@interface UnlockView ()
/** 被选中的按钮*/
@property (nonatomic, strong) NSMutableArray *selectedButton;
/** 用来记录当前手指的点*/
@property (nonatomic, assign) CGPoint currentPoint;
@end

@implementation UnlockView

- (NSMutableArray *)selectedButton{
    if (_selectedButton == nil) {
        _selectedButton = [NSMutableArray array];
    }
    return _selectedButton;
}

#pragma mark 从xib加载初始化
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];

}
#pragma mark 代码加载初始化.
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
#pragma mark 完成按钮的创建
- (void)setUp{

    for (int i = 0; i < 9; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        [button setImage: [UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];

        //为了方便记录拖线的顺序, 在这里为每一个button绑定tag
        button.tag = i;


        //为了能是button的父控件接收点击事件, 能够去到touch相关的方法, 需要将按钮的userInteractionEnabled设置为NO.
        button.userInteractionEnabled = NO;
        [self addSubview:button];

    }
}
#pragma mark 计算九宫格按钮的位置并布局.
- (void)layoutSubviews{
    [super layoutSubviews];

    int column = 3;
    CGFloat buttonWH = 74;
    CGFloat margin = (self.frame.size.width - column * buttonWH) / (column + 1);

    CGFloat buttonX;
    CGFloat buttonY;

    for (int i = 0; i < self.subviews.count; i++) {

        buttonX = margin + (margin + buttonWH) * (i % column);
        buttonY = margin + (margin + buttonWH) * (i / column);

        UIButton *button = self.subviews[i];

        button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
    }

}
#pragma mark 抽取方法 返回当前手指所在的点
- (CGPoint)getCurrentPoint:(NSSet *)touches{
    UITouch *fingerTouch = [touches anyObject];

    return [fingerTouch locationInView:self];
}
#pragma mark 抽取方法 如果点在当前按钮中就返回.
- (UIButton *)buttonContainsPoint:(CGPoint)point{

    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    
    return nil;
}

#pragma mark 手指在接触到屏幕, 或在屏幕移动上时, 将手指进过的按钮状态改为选中状态.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint currentPoint = [self getCurrentPoint:touches];



    //如果手指点在按钮上就将按钮设置为选中状态
    UIButton *button = [self buttonContainsPoint:currentPoint];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.selectedButton addObject:button];
    }

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [self getCurrentPoint:touches];


    //如果手指点在按钮上就将按钮设置为选中状态
    UIButton *button = [self buttonContainsPoint:currentPoint];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.selectedButton addObject:button];

    }

    //只要来带该方法就进行重绘.
    [self setNeedsDisplay];
    //获取当前手指所在点,
    self.currentPoint = currentPoint;
}
#pragma mark 手指离开屏幕来带该方法
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableString *selectedString = [NSMutableString string];
    //所有选中状态的按钮取消选中
    for (UIButton *button in self.selectedButton) {
        button.selected = NO;
        [selectedString appendFormat:@"%ld", button.tag];
    }
    //移除所有选中的按钮
    [self.selectedButton removeAllObjects];
    //重新绘制
    [self setNeedsDisplay];


    //在UIView中使用 UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"手势顺序为" message:selectedString preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];

    //获取当前控制器.
    UIViewController *currentViewController = [self currentTopViewController];

    //显示alertController
    [currentViewController presentViewController:alertController animated:YES completion:^{

    }];


}
#pragma mark 在View中获取当前控制器对象
- (UIViewController *)currentTopViewController {
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)drawRect:(CGRect)rect{
    //如果数组中没有值, 则不进行绘制.
    if(self.selectedButton.count <= 0) return;
    //如果数组有值, 则进行绘制
    UIBezierPath *drawPath = [UIBezierPath bezierPath];

        for (int i = 0; i < self.selectedButton.count; i++)
        {
            UIButton *button = self.selectedButton[i];
            if (i == 0) {

                [drawPath moveToPoint:button.center];
            }else
            {
                [drawPath addLineToPoint:button.center];
            }

        }


    [drawPath addLineToPoint:self.currentPoint];
    [drawPath setLineWidth:10];
    [drawPath setLineJoinStyle:kCGLineJoinRound];

    [[UIColor orangeColor] set];
    [drawPath stroke];

}
@end
