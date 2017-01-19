//
//  YYHItemInCellArray.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHItemInCellArray : NSObject
/** 标题*/
@property (nonatomic, strong) NSString *name;
/** 图片*/
@property (nonatomic, strong) NSString *icon;



- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)carInGroupWithDictionary:(NSDictionary *)dict;

@end
