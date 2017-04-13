//
//  YYHTopicVideoView.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYHTopicsItem;

@interface YYHTopicVideoView : UIView

/** 模型*/
@property (nonatomic, strong) YYHTopicsItem *topic;
+ (instancetype)yyhTopicVideoViewFromNib;

@end
