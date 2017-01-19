//
//  YYHCellItem.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHCellItem.h"
#import "YYHItemInCellArray.h"

@implementation YYHCellItem

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {

        self.header = dict[@"header"];

        self.footer = dict[@"footer"];
        self.rightView = dict[@"rightView"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *carsDict in dict[@"arrayForCell"])
        {
            YYHItemInCellArray *carsInGroup = [[YYHItemInCellArray alloc] initWithDictionary:carsDict];
            [temp addObject:carsInGroup];

        }
        self.arrayForCell = temp;
    }
    return  self;

}
+ (instancetype)cellItemWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}


@end
