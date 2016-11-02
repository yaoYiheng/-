//
//  YHCarsInGroup.m
//  16_11_02_索引条
//
//  Created by 姚懿恒 on 2016/11/2.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHCarsInGroup.h"

@implementation YHCarsInGroup

- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        self.carName = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}
+ (instancetype)carInGroupWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
