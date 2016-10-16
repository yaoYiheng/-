//
//  YHItemView.h
//  16_10_16_05_通过xib自定义View
//
//  Created by 姚懿恒 on 2016/10/16.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHItems;
@interface YHItemView : UIView

/** item*/
@property (nonatomic, strong) YHItems *items;

+(instancetype)items;


@end
