//
//  YHProvinceItem.h
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/26.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHProvinceItem : NSObject
/** 省份中的城市数组*/
@property (nonatomic, strong) NSArray *cities;
/** 省份名称*/
@property (nonatomic, strong) NSString *name;

+ (instancetype)provinceItemWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
