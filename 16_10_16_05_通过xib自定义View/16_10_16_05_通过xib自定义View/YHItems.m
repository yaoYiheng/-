//
//  YHItems.m
//  16_10_16_05_通过xib自定义View
//
//  Created by 姚懿恒 on 2016/10/16.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHItems.h"

@implementation YHItems
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.iconName = dict[@"iconName"];
        self.title = dict[@"title"];
    }
    return self;
}
+(instancetype)itemWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
