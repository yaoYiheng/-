//
//  YYHTabBar.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHTabBar;

@protocol YYHTabBarDelegate <NSObject>

- (void)tabBar:(YYHTabBar *)tabBar index:(NSInteger) index;

@end
@interface YYHTabBar : UIView



/** 模型数组*/
@property (nonatomic, strong) NSArray  *tabBarItems;

/** 代理属性*/
@property (nonatomic, weak)  id<YYHTabBarDelegate> delegate;

@end
