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
    for (int i = 0; i < 1000; i++) {
        NSLog(@"op1%@, %d,",[NSThread currentThread], i);
    }
    NSLog(@"%s--%d, %@", __func__, __LINE__, [NSThread currentThread]);

    //苹果官方的建议:每执行完一小段耗时操作的时候判断当前操作时候被取消
    if(self.isCancelled) return;

    for (int i = 0; i < 1000; i++) {
        NSLog(@"op2%@, %d,",[NSThread currentThread], i);
    }
    NSLog(@"%s--%d, %@", __func__, __LINE__, [NSThread currentThread]);

    if(self.isCancelled) return;

    for (int i = 0; i < 1000; i++) {
        NSLog(@"op3%@, %d,",[NSThread currentThread], i);
    }
    NSLog(@"%s--%d, %@", __func__, __LINE__, [NSThread currentThread]);

}
@end
