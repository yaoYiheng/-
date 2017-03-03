//
//  NSObject+Porperty.h
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Porperty)

//在分类中添加属性, 只会生成属性的声明, 并不会生成实现与成员变量.
@property NSString *name;
@end
