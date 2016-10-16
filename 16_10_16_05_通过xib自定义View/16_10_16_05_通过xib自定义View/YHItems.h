//
//  YHItems.h
//  16_10_16_05_通过xib自定义View
//
//  Created by 姚懿恒 on 2016/10/16.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHItems : NSObject
/** 图片名*/
@property (nonatomic, strong) NSString *iconName;
/** 标题*/
@property (nonatomic, strong) NSString *title;

+(instancetype)itemWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
