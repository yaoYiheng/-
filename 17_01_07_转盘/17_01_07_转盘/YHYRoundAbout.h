//
//  YHYRoundAbout.h
//  17_01_07_转盘
//
//  Created by 姚懿恒 on 2017/1/7.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHYRoundAbout : UIView

//快速创建方法
+ (instancetype)roundAbout;

//开始旋转
- (void)startRotate;
//停止旋转
- (void)pause;
@end
