//
//  YYHPopMenuView.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHPopMenuView.h"

#define YYHKeyWindow [UIApplication sharedApplication].keyWindow


@implementation YYHPopMenuView

+ (instancetype)showAtPoint:(CGPoint)point{


    YYHPopMenuView *popView = [[NSBundle mainBundle] loadNibNamed:@"YYHPopMenuView" owner:nil options:nil][0];

    popView.center = point;


    [YYHKeyWindow addSubview:popView];

    return popView;
}

- (IBAction)close:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(popMenuViewDidClickOnCloseButton:)]) {
        [self.delegate popMenuViewDidClickOnCloseButton:self];
    }


}

- (void)disapperAtPoint:(CGPoint)point{

    [UIView animateWithDuration:4 animations:^{
        self.center = point;
        self.transform = CGAffineTransformMakeScale(0.2, 0.2);
    }];
}


@end
