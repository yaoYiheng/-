//
//  UIView+Frame.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 在分类中编写属性, 只会生成getter 与setter方法, 不会生成成员属性
 */
/** 宽*/
@property (nonatomic, assign) CGFloat Width;
/** 高*/
@property (nonatomic, assign) CGFloat Height;
/** x*/
@property (nonatomic, assign) CGFloat x;
/** y*/
@property (nonatomic, assign) CGFloat y;

@end
