//
//  statusItem.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "statusItem.h"

@implementation statusItem



//使用KVC实现字典转模型
/*
 虽然也能够同KVC实现字典转模型, 但是对于模型中 譬如NSDictionary, NSArray还需要进行进一步转换的
 类型, KVC显得有点力不从心.
 解决方案, 为NSOBject添加分类, 使用runtime.
 */

+ (instancetype)itemsWithDictionary:(NSDictionary *)dict{

    statusItem *items = [[self alloc] init];

    [items setValuesForKeysWithDictionary:dict];

    return items;

}
/*
 在开发中, 接收到来自服务器的数据可能会有很多, 而模型只是用来保存所需要的数据
 模型中不会用到所有来自服务器的数据, 这时就不能顺利的使用KVC进行字典转模型的
 操作.
 例如:如果注释掉该模型中的某一属性后, 该程序就会崩溃, 报setValue:forUndefinedKey:错误
 这里可以重写系统方法

    什么时候需要重写系统方法? 
    1.想给系统方法添加额外功能 
    2.不想要系统方法实现

 */

/**
 什么都不做, 覆盖掉系统的原来的做法, 这样同样能够实现KVC转模型
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
