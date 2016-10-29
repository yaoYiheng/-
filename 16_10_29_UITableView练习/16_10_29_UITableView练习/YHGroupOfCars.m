//
//  YHGroupOfCars.m
//  16_10_29_UITableView练习
//
//  Created by 姚懿恒 on 2016/10/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHGroupOfCars.h"
#import "YHCar.h"

@implementation YHGroupOfCars
//通过传入的字典, 将字典转化为模型.
+(instancetype)groupOfCarsWithDictionary:(NSDictionary *)dict{
    YHGroupOfCars *group = [[YHGroupOfCars alloc] init];
    group.header = dict[@"header"];
    group.footer = dict[@"footer"];

    NSMutableArray *carsArray = [NSMutableArray array];
    for (NSDictionary *dictInDict in dict[@"cars"]) {
        YHCar *car = [YHCar carWithDictionary:dictInDict];

        [carsArray addObject:car];
    }
    group.cars = carsArray;


    return group;

}

@end
