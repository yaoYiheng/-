//
//  YYHTool.m
//  17_01_27_ARC环境下实现单例模式
//
//  Created by 姚懿恒 on 2017/1/27.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTool.h"

@implementation YYHTool

static YYHTool *_instance;


/**
 重写类方法
 + (instancetype)allocWithZone:(struct _NSZone *)zone, ( + (instancetype)alloc底层会调用该方法)
 使用dispatch_once创建单例对象, 本身是线程安全

 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


/**
 提供类方法

 */
+ (instancetype)shareTool{
    return [[self alloc] init];;

}
#pragma mark 更严谨的做法, 加上copy以及mutableCopy
- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}
- (id)mutableCopy{
    return _instance;
}
#if __has_feature(objc_arc)
//条件满足 ARC就什么也不做

#else
//不然就执行以下代码
- (instancetype)retain{
    return _instance;
}
- (oneway void)release{

}
- (NSUInteger)retainCount{
    return MAXFLOAT;
}

#endif


@end
