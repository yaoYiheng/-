//
//  YYHTagItem.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/22.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHTagItem : NSObject
/** 标签名*/
@property (nonatomic, strong) NSString *theme_name;
/** 订阅人数*/
@property (nonatomic, strong) NSString *sub_number;
/** 图片URL*/
@property (nonatomic, strong) NSString *image_list;

@end
