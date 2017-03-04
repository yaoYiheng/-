//
//  NSDictionary+Property.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "NSDictionary+Property.h"

@implementation NSDictionary (Property)

- (NSString *)creatPorpertyCode{
    NSMutableString *string = [NSMutableString string];

    //遍历字典的每一个键值.
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

        //返回每一个值的具体的类型, 根据类型对属性进行拼接
        NSLog(@"%@", [obj class]);
//        NSLog(@"%@", key);

        // isKindOfClass:判断是否是当前类或者子类
        if ([obj isKindOfClass:[NSString class]]) {
            [string appendFormat:@"\n@property (nonatomic, strong) NSString *%@;\n",key];
        }
        else if ([key isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
        {
            [string appendFormat:@"\n@property (nonatomic, assign) BOOL %@;\n", key];

        }
        else if ([obj isKindOfClass:[NSNumber class]]){

            [string appendFormat:@"\n@property (nonatomic, assign) NSInteger %@;\n",key];
        }
        else if ([obj isKindOfClass:[NSArray class]]){
            [string appendFormat:@"\n@property (nonatomic, strong) NSArray *%@;\n", key];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]){
            [string appendFormat:@"\n@property (nonatomic, strong) NSDictionary *%@;\n", key];
        }
    }];




    return string;
}

@end
