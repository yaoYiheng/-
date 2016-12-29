//
//  UnlockView.m
//  16_12_29_手势解锁
//
//  Created by 姚懿恒 on 2016/12/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "UnlockView.h"

@implementation UnlockView
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
    if (button) {
        button.selected = YES;
    }

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [self getCurrentPoint:touches];

    //如果手指点在按钮上就将按钮设置为选中状态
    UIButton *button = [self buttonContainsPoint:currentPoint];
    if (button) {
        button.selected = YES;
    }

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
@end
