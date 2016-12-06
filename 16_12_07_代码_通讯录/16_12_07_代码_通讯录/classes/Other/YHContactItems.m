//
//  YHContactItems.m
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHContactItems.h"

@implementation YHContactItems
- (instancetype)initWithName:(NSString *)name phone:(NSString *)phone{
    if (self = [super init]) {
        self.name = name;
        self.phone = phone;
    }
    return self;
}
+ (instancetype)contactItemWithName:(NSString *)name phone:(NSString *)phone{
    return [[self alloc] initWithName:name phone:phone];
}

@end
