//
//  ViewController.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/2.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

// 解决消息机制方法提示步骤
// 查找build setting -> 搜索msg
#import "Human.h"

/*
 *	方法调用的本质，就是让对象发送消息。
 *	objc_msgSend,只有对象才能发送消息，因此以objc开头.
 *	使用`消息机制`前提，必须导入#import <objc/message.h>
 *	消息机制简单使用
 *	clang -rewrite-objc main.m 查看最终生成代码(终端使用)

 */

/*
 runtime使用场景, 需要调用私有方法时.
 */
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    objc_msgSend(self, @selector(exchangeMethod));

}


- (void)runtime{
    //Human *human = [Human alloc];底层实现
    Human *human = objc_msgSend(objc_getClass("Human"), sel_registerName("alloc"));

    //human = [human init];底层实现
    human = objc_msgSend(human, sel_registerName("init"));

    //    [human eat];
    /*
     在这里eat为私有方法, 通过普通方法无法调用, 通过runtim机制则可以调用.
     */
    objc_msgSend(human, sel_registerName("eat"));

    //调用需要传入参数的方法.
    objc_msgSend(human, @selector(run:), 30);

    /**
     // 方法调用流程
     // 怎么去调用eat方法 ,对象方法:类对象的方法列表 类方法:元类中方法列表
     // 1.通过isa去对应的类中查找
     // 2.注册方法编号
     // 3.根据方法编号去查找对应方法
     // 4.找到只是最终函数实现地址,根据地址去方法区调用对应函数
     */
}


/*
 Runtime(交换方法):只要想修改系统的方法实现
 */

- (void)exchangeMethod{

    UIImage *image = [UIImage imageNamed:@"123.png"];
}
@end
