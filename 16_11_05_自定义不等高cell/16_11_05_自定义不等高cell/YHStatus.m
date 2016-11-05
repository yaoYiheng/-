//
//  YHStatus.m
//  16_11_05_自定义不等高cell
//
//  Created by 姚懿恒 on 2016/11/5.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHStatus.h"

@implementation YHStatus

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)statusWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
