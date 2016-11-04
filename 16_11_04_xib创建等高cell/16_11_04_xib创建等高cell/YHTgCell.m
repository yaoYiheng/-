//
//  YHTgCell.m
//  16_11_04_xib创建等高cell
//
//  Created by 姚懿恒 on 2016/11/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHTgCell.h"

@implementation YHTgCell


- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;

}
+ (instancetype)tgcellWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
