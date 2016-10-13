//
//  Item.m
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "Item.h"

@implementation Item


- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.title = dict[@"name"];
    }
    return self;
}

+ (instancetype)itemWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
