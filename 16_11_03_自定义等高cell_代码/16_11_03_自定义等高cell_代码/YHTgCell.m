//
//  YHTgCell.m
//  16_11_03_自定义等高cell_代码
//
//  Created by 姚懿恒 on 2016/11/3.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHTgCell.h"

@implementation YHTgCell
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {

        //如果使用该方法, 则键值对名必须与传入的相一致.
        [self setValuesForKeysWithDictionary:dict];

    }
    return self;
}


+ (instancetype)tgcellWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
