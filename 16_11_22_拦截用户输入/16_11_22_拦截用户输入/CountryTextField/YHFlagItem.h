//
//  YHFlagItem.h
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHFlagItem : NSObject
/** 国家名*/
@property (nonatomic, strong) NSString *name;
/** 国旗名*/
@property (nonatomic, strong) UIImage *icon;

+ (instancetype)flagItemWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
