//
//  statusItem.h
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface statusItem : NSObject
//使用为字典添加的分类, 自动生成这些属性.
//@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) NSInteger reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) NSInteger attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, strong) User *user;

+ (instancetype)itemsWithDictionary:(NSDictionary *)dict;

@end
