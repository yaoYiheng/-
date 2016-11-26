//
//  YHProvinceItem.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/26.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHProvinceItem.h"

@implementation YHProvinceItem


+ (instancetype)provinceItemWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
- (instancetype)initWithDictionary:(NSDictionary *)dict;
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
