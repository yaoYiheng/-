//
//  YYHTabBar.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTabBar.h"

@interface YYHTabBar ()
/** <#comments#>*/
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation YYHTabBar

- (UIButton *)publishButton{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

        //图片不显示, 需要调用该方法, 使按钮适应图片.
        [publishButton sizeToFit];

        _publishButton = publishButton;

        [self addSubview:publishButton];

    }
    return _publishButton;
}


/**
 在该方法中, 将YYHTabBar分成5等分, 并且预留出中间的位置添加发布按钮
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat barButtonW = self.yyh_width / self.subviews.count + 1;

    int index = 0;
    for (UIView *tabBarButton in self.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            tabBarButton.frame = CGRectMake(index * barButtonW, 0, barButtonW, self.yyh_height);

            if (index == 1) {
                index = 2;
            }
            index++;

        }

    }

    self.publishButton.center = CGPointMake(self.yyh_width / 2, self.yyh_height / 2);

//    NSLog(@"%@", self.subviews);
}
@end
