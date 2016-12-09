//
//  Person.h
//  16_12_08_plist的存储
//
//  Created by 姚懿恒 on 2016/12/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

//遵守NSCoding协议, 才能完成对对象的归档操作.
@interface Person : NSObject<NSCoding>
/** 姓名*/
@property (nonatomic, strong) NSString  *name;
/** 年龄*/
@property (nonatomic, assign) int age;

@end
