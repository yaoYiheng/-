//
//  YYHTopicVideoView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicVideoView.h"

@implementation YYHTopicVideoView

+ (instancetype)yyhTopicVideoViewFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


@end
