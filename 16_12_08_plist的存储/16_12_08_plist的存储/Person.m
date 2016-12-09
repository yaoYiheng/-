//
//  Person.m
//  16_12_08_plist的存储
//
//  Created by 姚懿恒 on 2016/12/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "Person.h"

@implementation Person

//当调用archiveRootObject:toFile:方法时, 底层会调用该方法, 去询问要保存对象的哪些属性.
//须遵守NSCoding协议.
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
}

//当调用unarchiveObjectWithFile:方法时, 底层会initWithCoder:方法, 告诉它去获取对象的哪些属性.
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
       self.name = [aDecoder decodeObjectForKey:@"name"];
       self.age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}

@end
