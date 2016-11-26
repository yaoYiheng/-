//
//  YHCitiesItem.m
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHCitiesItem.h"

@implementation YHCitiesItem

+(instancetype)citiesItemWithDictionary:(NSDictionary *)dict{
    YHCitiesItem *item = [[YHCitiesItem alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;

}
@end
