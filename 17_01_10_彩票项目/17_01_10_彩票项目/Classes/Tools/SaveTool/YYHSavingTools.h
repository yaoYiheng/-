//
//  YYHSavingTools.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHSavingTools : NSObject
/**
 消除pointer is missing a nullability type specifier警告, 在含有nullable的方法前后添加

 NS_ASSUME_NONNULL_BEGIN
 
含有 nullable 的方法
 
 NS_ASSUME_NONNULL_END
 
 */

NS_ASSUME_NONNULL_BEGIN

+ (nullable id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName;

NS_ASSUME_NONNULL_END

@end
