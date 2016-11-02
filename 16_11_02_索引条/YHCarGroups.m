//
//  YHCarGroups.m
//  16_11_02_索引条
//
//  Created by 姚懿恒 on 2016/11/2.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHCarGroups.h"
#import "YHCarsInGroup.h"

@implementation YHCarGroups
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {

        self.title = dict[@"title"];

        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *carsDict in dict[@"cars"])
        {
            YHCarsInGroup *carsInGroup = [[YHCarsInGroup alloc] initWithDictionary:carsDict];
            [temp addObject:carsInGroup];

        }
        self.carArrays = temp;
    }
    return  self;

}
+ (instancetype)carGroupWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
