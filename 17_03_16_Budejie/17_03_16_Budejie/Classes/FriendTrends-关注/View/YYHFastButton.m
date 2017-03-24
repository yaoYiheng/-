//
//  YYHFastButton.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/24.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHFastButton.h"

@implementation YYHFastButton

- (void)layoutSubviews{

    [super layoutSubviews];
    self.imageView.yyh_y = 0;
    self.imageView.yyh_centerX = self.yyh_width * 0.5;

    //调用该方法后, 会修改titleLabel的centerX的值, 所以该方法需要放到设置centerX之前调用
    [self.titleLabel sizeToFit];

    self.titleLabel.yyh_centerX = self.yyh_width * 0.5;

    self.titleLabel.yyh_y = CGRectGetMaxY(self.imageView.frame);

//    NSLog(@"%f", self.titleLabel.center.x);
}

@end
