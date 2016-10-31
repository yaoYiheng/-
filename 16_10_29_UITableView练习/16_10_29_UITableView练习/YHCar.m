//
//  YHCar.m
//  16_10_29_UITableView练习
//
//  Created by 姚懿恒 on 2016/10/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHCar.h"

@implementation YHCar

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {

        self.carIcon = dict[@"icon"];
        self.carName = dict[@"name"];
    }
    return self;
}


+ (instancetype)carWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
