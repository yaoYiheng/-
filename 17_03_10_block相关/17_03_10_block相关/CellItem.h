//
//  CellItem.h
//  17_03_10_block相关
//
//  Created by 姚懿恒 on 2017/3/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellItem : NSObject
/** <#comments#>*/
@property (nonatomic, strong) NSString *mission;

/** 该block用来保存每个cell的会做的任务*/
@property (nonatomic, strong) void(^missionBlock)();

+ (instancetype)itemWithString:(NSString *)mission;

@end
