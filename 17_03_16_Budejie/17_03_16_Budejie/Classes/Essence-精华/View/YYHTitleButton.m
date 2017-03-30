//
//  YYHTitleButton.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/30.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTitleButton.h"

@implementation YYHTitleButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
