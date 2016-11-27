//
//  YHContryItem.m
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHContryItem.h"

@implementation YHContryItem

- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:obj forKey:key];
        }];
    }
    return self;

}
+ (instancetype)contryItemWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

/**
 重写setIcon方法, 在该方法中,完成对图片的赋值, 而不需要在外界通过字符串的形式再转成图片.
 次方法需与 
 [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
 [self setValue:obj forKey:key];
 }];
 相互配合使用

 */
- (void)setIcon:(UIImage *)icon{
    NSString *iconName = (NSString *)icon;
    _icon = [UIImage imageNamed:iconName];
}

@end
