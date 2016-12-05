//
//  YHAddItem.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHAddItem.h"

@implementation YHAddItem
- (instancetype)initWithName:(NSString *)name andPhoneNumber:(NSString *)number;
{
    if (self = [super init]) {
        self.userName = name;
        self.phoneNumber = number;
    }
    return self;
}
+ (instancetype)addItemWithName:(NSString *)name andPhoneNumber:(NSString *)number{
    return [[self alloc] initWithName:name andPhoneNumber:number];
}


@end
