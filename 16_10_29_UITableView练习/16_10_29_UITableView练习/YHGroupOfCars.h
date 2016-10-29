//
//  YHGroupOfCars.h
//  16_10_29_UITableView练习
//
//  Created by 姚懿恒 on 2016/10/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGroupOfCars : NSObject
/** 头部标题*/
@property (nonatomic, strong) NSString *header;
/** 底部描述*/
@property (nonatomic, strong) NSString *footer;
/** 车数组模型*/
@property (nonatomic, strong) NSArray *cars;

+ (instancetype)groupOfCarsWithDictionary:(NSDictionary *)dict;
@end
