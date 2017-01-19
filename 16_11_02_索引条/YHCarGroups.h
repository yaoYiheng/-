//
//  YHCarGroups.h
//  16_11_02_索引条
//
//  Created by 姚懿恒 on 2016/11/2.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YHCarGroups : NSObject

/** 索引title*/
@property (nonatomic, strong) NSString *title;
/** 车数组*/
@property (nonatomic, strong) NSArray *cars;

//- (instancetype)initWithDictionary:(NSDictionary *)dict;
//+ (instancetype)carGroupWithDictionary:(NSDictionary *)dict;

@end
