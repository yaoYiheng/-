//
//  YHCitiesItem.h
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCitiesItem : NSObject
/** 城市数组*/
@property (nonatomic, strong) NSArray *cities;
/** 省名称*/
@property (nonatomic, strong) NSString *name;

+ (instancetype)citiesItemWithDictionary:(NSDictionary *)dict;


@end
