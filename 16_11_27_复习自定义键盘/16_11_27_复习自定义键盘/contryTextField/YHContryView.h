//
//  YHContryView.h
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHContryItem;

@interface YHContryView : UIView
/** 国家*/
@property (nonatomic, strong) YHContryItem *countryItem;

+(instancetype)contryView;

@end
