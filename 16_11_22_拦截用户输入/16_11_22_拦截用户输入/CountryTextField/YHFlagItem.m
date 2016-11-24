//
//  YHFlagItem.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHFlagItem.h"

@implementation YHFlagItem
+ (instancetype)flagItemWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];

}
/**
 通过输入相对应的key完成赋值操作, 缺点: 无错误检查, 容易出错, 所以不采用这种方法,
 */
#pragma mark 通过传入的字典为成员属性进行赋值操作

//- (instancetype)initWithDictionary:(NSDictionary *)dict{
//    if (self = [super init]) {
//        self.name = dict[@"name"];
//        self.icon = dict[@"icon"];
//    }
//    return self;
//}

/**
 为了解决上一种写法出现的问题, 所以采用以下写法, 使用KVC方法赋值, 调用setValuesForKeysWithDictionary:传入字典, 自动完成对成员变量的赋值
 优点: 无需手动输入键值, 提高正确性.
 */
//- (instancetype)initWithDictionary:(NSDictionary *)dict{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}

/**
 setValuesForKeysWithDictionary的底层实现原理.
 遍历传入的字典, 然后为相对应的键值进行赋值操作.通过setValue:forKey:方法.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:obj forKey:key];
            /**
             setValue:forKey:方法的实现原理:

             1.检查对应的key值有没有实现set方法, 如果有就会自动调用set方法进行赋值.
             2.如果没有set方法, 就检查有没有与key相同且带有下划线的成员变量, 如果有就进行赋值.
             3.如果没有带下划线的成员变量, 就会检查是否有与key值同名的成员变量 , 如果有就赋值.
             4.如果以上都没有, 就会报错.
             
             */
        }];
    }
    return self;
}

/**
 为了能给flagView最需要的子控件(一张图片UIImage, 而不是字符串), 可以在通过字典传入时, 通过kvc在调用setValue:forKey:方法时,对set方法进行重写, 使其返回类型为UIImage.

 */
- (void)setIcon:(UIImage *)icon{
    //强制类型转换. icon为NSString类型
    NSString *iconName = (NSString *)icon;
    _icon = [UIImage imageNamed:iconName];
}
@end
