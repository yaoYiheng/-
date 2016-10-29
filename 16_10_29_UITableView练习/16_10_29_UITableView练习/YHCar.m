//
//  YHCar.m
//  16_10_29_UITableView练习
//
//  Created by 姚懿恒 on 2016/10/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHCar.h"

@implementation YHCar


+ (instancetype)carWithDictionary:(NSDictionary *)dict{
    YHCar *car = [[YHCar alloc] init];

    car.carIcon = dict[@"icon"];
    car.carName = dict[@"name"];
    return car;
}

@end
