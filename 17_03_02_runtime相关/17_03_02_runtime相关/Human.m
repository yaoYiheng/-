//
//  Human.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/2.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "Human.h"
//想要使用runtime, 需要先导入头文件
#import <objc/message.h>

@implementation Human
- (void)eat{
    NSLog(@"%s", __func__);
}

- (void)run:(NSInteger)meter{
    NSLog(@"跑了%ldkm", meter);
}


/**
 // 什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法,进行处理
 // 作用:动态添加方法,处理未实现

 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{

    if (sel == NSSelectorFromString(@"sleep")) {
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名
        // type: 方法类型
        class_addMethod(self, sel, (IMP)aaa, "v@:");
        return YES;
    }
    else if (sel == NSSelectorFromString(@"sleepFor:")){
        class_addMethod(self, sel, (IMP)bbb, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];


}
#pragma mark -----动态添加的方法-----

void aaa(id self, SEL _cmd){
    NSLog(@"睡觉");
}
void bbb(id self, SEL _cmd, NSNumber *hours){
    NSLog(@"睡了%@小时", hours);
}

@end
