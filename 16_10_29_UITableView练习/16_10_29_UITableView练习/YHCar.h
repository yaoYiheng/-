//
//  YHCar.h
//  16_10_29_UITableView练习
//
//  Created by 姚懿恒 on 2016/10/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCar : NSObject
/** 车名*/
@property (nonatomic, strong) NSString *carName;
/** 车图标*/
@property (nonatomic, strong) NSString *carIcon;
+ (instancetype)carWithDictionary:(NSDictionary *)dict;

@end
