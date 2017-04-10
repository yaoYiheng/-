//
//  YYHTopicVoiceView.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYHTopicsItem;

@interface YYHTopicVoiceView : UIView

+ (instancetype)yyhTopicVoiceFromNib;

/** <#comments#>*/
@property (nonatomic, strong) YYHTopicsItem *topic;
@end
