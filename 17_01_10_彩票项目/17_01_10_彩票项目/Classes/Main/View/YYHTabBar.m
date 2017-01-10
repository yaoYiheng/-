//
//  YYHTabBar.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTabBar.h"
#import "YYHTabButton.h"

@interface YYHTabBar ()
/** 记录选中的数组*/
@property (nonatomic, weak) UIButton *selectedButton;

@end


@implementation YYHTabBar


#pragma mark -通过传入的items数组设置子控件
- (void)setTabBarItems:(NSArray *)tabBarItems{
    _tabBarItems = tabBarItems;

    for (int i = 0; i < tabBarItems.count; i++) {
        UIButton *button = [[YYHTabButton alloc] init];

        //从数组中取出对应的 UITabBarItem
        UITabBarItem *tabBar= tabBarItems[i];

        [button setBackgroundImage:tabBar.image forState:UIControlStateNormal];
        [button setBackgroundImage:tabBar.selectedImage forState:UIControlStateSelected];

        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchDown];

        [self addSubview:button];

        if (i == 0) {
            [self buttonOnClick:button];
        }

    }
    
}

- (void)buttonOnClick:(UIButton *)button{

    //1.取消上一次的选中
    self.selectedButton.selected = NO;

    //2.设置当前按钮选中
    button.selected = YES;

    //3.记录当前选中的按钮
    self.selectedButton = button;
}

#pragma mark 设置子控件位置及尺寸
- (void)layoutSubviews{

    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.tabBarItems.count;
    CGFloat buttonH = self.frame.size.height;


    int index;

    //设置每一个按钮的位置及大小
    for (UIButton *button in self.subviews) {

        buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }

}

@end
