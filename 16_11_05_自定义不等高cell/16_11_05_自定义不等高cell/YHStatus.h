//
//  YHStatus.h
//  16_11_05_自定义不等高cell
//
//  Created by 姚懿恒 on 2016/11/5.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHStatus : NSObject
/** 微博内容*/
@property (nonatomic, strong) NSString *text;
/** 微博头像*/
@property (nonatomic, strong) NSString *icon;
/** 图片*/
@property (nonatomic, strong) NSString *picture;
/** 昵称*/
@property (nonatomic, strong) NSString *name;
/**是否会员*/
@property (nonatomic, assign, getter=isVip) BOOL vip;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)statusWithDictionary:(NSDictionary *)dict;

@end
