//
//  YHAddItem.h
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAddItem : NSObject
/** 姓名*/
@property (nonatomic, strong) NSString *userName;
/** 电话*/
@property (nonatomic, strong) NSString *phoneNumber;

- (instancetype)initWithName:(NSString *)name andPhoneNumber:(NSString *)number;
+ (instancetype)addItemWithName:(NSString *)name andPhoneNumber:(NSString *)number;

@end
