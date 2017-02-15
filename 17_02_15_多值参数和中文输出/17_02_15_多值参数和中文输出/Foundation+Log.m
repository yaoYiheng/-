//
//  NSDictionary+Log.m
//  17_02_15_多值参数和中文输出
//  重写系统的方法控制输出
//  Created by 姚懿恒 on 2017/2/15.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{

    NSMutableString *string = [NSMutableString  string];

    [string appendString:@"{"];

    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"%@:", key];
        [string appendFormat:@"%@,", obj];
    }];

    [string appendString:@"}"];

    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }


    return string;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{

    NSMutableString *string = [NSMutableString string];

    [string appendString:@"["];

        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [string appendFormat:@"%@,\n",obj];
        }];
    [string appendString:@"]"];

    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }

    return string;
}



@end

