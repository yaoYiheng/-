//
//  NSObject+Model.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)


// 获取类里面所有方法
// class_copyMethodList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)// 本质:创建谁的对象


// 获取类里面属性
//  class_copyPropertyList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)

+ (instancetype)modelWithDictionary:(NSDictionary *)dict{

    id model = [[self alloc] init];

    //通过runtime获取调用该方法的类的成员变量数组
    unsigned int outCount = 0;
    Ivar *ivarList = class_copyIvarList(self, &outCount);

    //遍历成员变量数组
    for (int i = 0 ; i < outCount; i++) {

        //从数组中拿到下标为i的_var;
        Ivar ivar = ivarList[i];



        /*
         返回一个包含实例变量名称的C字符串。
         ivar_getName(ivar)
         */
        //将返回的C语言的字符串的成员变量转换成NSString对象
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];

        //获取成员变量的Type
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];

        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];



        //将带下划线的成员变量转换成与字典中一致的key
        NSString *key = [ivarName substringFromIndex:1];

        //通过key来获得对应的值.
        id value = dict[key];


        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            //当这个成员变量的类型为字典类型, 且不是系统类时, 才需要进行字典转模型的操作.

            //获取ivarType的类型
            Class ivarClass = NSClassFromString(ivarType);



            value = [ivarClass modelWithDictionary:value];
        }


        //如果有值, 调用setValue:(nullable id)value forKey:(NSString *)key为模型赋值.
        if (value) {
            [model setValue:value forKey:key];
        }


    }

    return model;
}

@end
