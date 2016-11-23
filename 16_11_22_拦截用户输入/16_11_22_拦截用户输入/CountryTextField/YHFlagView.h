//
//  YHFlagView.h
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHFlagItem;
@interface YHFlagView : UIView
/** 模型*/
@property (nonatomic, strong) YHFlagItem *flagItem;

+(instancetype)flagView;
@end
