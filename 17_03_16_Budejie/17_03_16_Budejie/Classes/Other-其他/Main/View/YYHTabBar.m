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
/** <#comments#>*/
@property (nonatomic, weak) UIControl *selectedTabBarButton;

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
    for (UIControl *tabBarButton in self.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            tabBarButton.frame = CGRectMake(index * barButtonW, 0, barButtonW, self.yyh_height);
            
            if (index == 0 && self.selectedTabBarButton == nil) {
                self.selectedTabBarButton = tabBarButton;
            }
//            NSLog(@"%@", tabBarButton.superclass);
            //为tabBarButton添加点击事件,
            [tabBarButton addTarget:self action:@selector(barButtonClick:) forControlEvents:UIControlEventTouchUpInside];

            if (index == 1) {
                index = 2;
            }
            index++;

        }

    }

    self.publishButton.center = CGPointMake(self.yyh_width / 2, self.yyh_height / 2);

//    NSLog(@"%@", self.subviews);
}


/**
 当第二次点击时,才会调用该方法.
 
 实现: 保存第一次点击的按钮, 只有两次一样时, 才调用

 @param tabBarButton <#tabBarButton description#>
 */
- (void)barButtonClick:(UIControl *)tabBarButton{

    if (self.selectedTabBarButton == tabBarButton) {
        YYHFunc
    }
    self.selectedTabBarButton = tabBarButton;


}
@end
