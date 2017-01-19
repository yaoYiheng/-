//
//  YYHCellItem.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHCellItem : NSObject

/** 头标题*/
@property (nonatomic, strong) NSString *header;
/** 足标题*/
@property (nonatomic, strong) NSString *footer;
/** cell数组*/
@property (nonatomic, strong) NSArray *arrayForCell;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)cellItemWithDict:(NSDictionary *)dict;

@end
