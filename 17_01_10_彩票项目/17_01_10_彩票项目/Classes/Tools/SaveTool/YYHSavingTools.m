//
//  YYHSavingTools.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHSavingTools.h"

@implementation YYHSavingTools
+ (nullable id)objectForKey:(NSString *)defaultName{

    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName{
    //屏蔽外界传入nil
    if (defaultName) {
        
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

@end
