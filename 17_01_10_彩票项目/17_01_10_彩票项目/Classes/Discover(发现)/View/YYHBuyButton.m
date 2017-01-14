//
//  YYHBuyButton.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/13.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHBuyButton.h"

@implementation YYHBuyButton

//调整按钮titleLabel与ImageView的位置.
//可自定义UIButton, 重写layoutSubviews方法, 由于设置title与image与来两次该方法, 所以需要加一个判断, 只有第一次来该方法时, 才交换两个控件的位置
- (void)layoutSubviews{
    [super layoutSubviews];

    if (self.imageView.x < self.titleLabel.x) {
        self.titleLabel.x = self.imageView.x;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    }
}
//封装标题按钮, 外界传入新标题或图片时, 重新布局控件的位置.
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
