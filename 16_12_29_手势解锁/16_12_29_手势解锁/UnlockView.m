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

@end
