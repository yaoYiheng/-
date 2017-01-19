//
//  YYHItemInCellArray.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHItemInCellArray.h"

@implementation YYHItemInCellArray

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];

    }
    return self;
}
+ (instancetype)carInGroupWithDictionary:(NSDictionary *)dict{
    return [self carInGroupWithDictionary:dict];
}

@end
