//
//  CellItem.m
//  17_03_10_block相关
//
//  Created by 姚懿恒 on 2017/3/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem

+ (instancetype)itemWithString:(NSString *)mission{
    CellItem *item = [[self alloc] init];
    item.mission = mission;

    return item;
}
@end
