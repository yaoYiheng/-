//
//  YHCarsInGroup.h
//  16_11_02_索引条
//
//  Created by 姚懿恒 on 2016/11/2.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCarsInGroup : NSObject
/** 车名*/
@property (nonatomic, strong) NSString *carName;
/** 车图标名*/
@property (nonatomic, strong) NSString *icon;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)carInGroupWithDictionary:(NSDictionary *)dict;


@end
