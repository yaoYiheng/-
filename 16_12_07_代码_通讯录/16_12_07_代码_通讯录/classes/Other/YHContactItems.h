//
//  YHContactItems.h
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHContactItems : NSObject
/** 姓名*/
@property (nonatomic, strong) NSString *name;
/** 电话*/
@property (nonatomic, strong) NSString *phone;

- (instancetype)initWithName:(NSString *)name phone:(NSString *)phone;
+ (instancetype)contactItemWithName:(NSString *)name phone:(NSString *)phone;
@end
