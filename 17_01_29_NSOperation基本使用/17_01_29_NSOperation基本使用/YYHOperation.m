//
//  YYHOperation.m
//  17_01_29_NSOperation基本使用
//
//  Created by 姚懿恒 on 2017/1/29.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHOperation.h"

@implementation YYHOperation


/**
 自定义NSOperation, 可以将需要执行的代码隐藏到该方法中.
 
 这样做的好处有:
 提高代码复用率
 隐藏代码
 */
- (void)main{
    NSLog(@"%s--%d, %@", __func__, __LINE__, [NSThread currentThread]);
}
@end
