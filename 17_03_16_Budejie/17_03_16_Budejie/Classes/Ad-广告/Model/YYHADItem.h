//
//  YYHADItem.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/21.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHADItem : NSObject
/** 广告的地址*/
@property (nonatomic, strong) NSString *ori_curl;

/** 广告图片地址*/
@property (nonatomic, strong) NSString *w_picurl;
/** 广告宽高*/
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end
