//
//  ViewController.m
//  17_03_05_extern_static_const
//
//  Created by 姚懿恒 on 2017/3/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
 
 const:与宏的区别
     1.编译时刻 宏:预编译 const:编译
     2.编译检查 宏没有编译检查,const有编译检查
     3.宏的好处 定义函数.方法, const不可以
     4.宏的坏处 大量使用宏,会导致预编译时间过长

 const作用:  1.修饰右边基本变量或者指针变量
            2.被const修饰变量只读

             int * const p;  // p:只读  *p:变量
             int const * p1; // p1:变量 *p1:只读
             const int * p2; // p2:变量 *p2:只读
             const int * const p3; // p3:只读 *p3:只读
             int const * const p4; // p4:只读 *p4:只读
 
 在开发中如何使用:
         1.修饰全局变量 => 全局只读变量 => 代替宏
            NSString * const name = @"name";
            防止name在其他方法中被修改.

         2.修饰方法中参数


 */

/*
    static作用: 
        1. 当static修饰局部变量时, 可以延长被修饰的局部变量的生命周期, 正常情况变量的作用域只是在方法内部, 方法调用结束后, 就会被释放, 但被static修饰的局部变量会一直存在直到程序退出.

        2.当static修饰全局变量时, 会修改全局变量的作用域, 使其仅在当前文件下使用.

            举例: 在当前文件中声明了一个NSString *name = @"123";的全局变量, 
                在AppDelegate.m文件中, 使用extern NSString *name;对该全局变量进行了声明,
                在某方法中吗可以成功访问该字符串, 但是当把当前文件中声明的全局变量前加上了关键字static后, 立刻报错.
 

        extern作用:声明外部全局变量,注意:extern只能用于声明,不能用于定义
        extern工作原理:先会去当前文件下查找有没有对应全局变量,如果没有,才回去其他文件查找

             static和const联合使用:

             const修饰全局变量
             static修饰全局变量,修改作用域
             static NSString * const name = @"name";
 
 extern和const联合使用:
    使用场景: 在多人开发中, 可能在不同的模块中, 会定义相同的全局变量, 当项目合并时, 就会造成冲突
    规定:全局变量不能定义在自己类中,自己创建全局文件管理全局东西
    
    解决方案: 新建一个GlobalConst的类, 在其.m文件中使用const关键字定义整个项目中的全局变量
            在其.h文件中, 使用extern关键字对局部变量进行声明, 需要使用这些全局变量时, 直接导入
            GlobalConst.h文件即可.

 */

#import "ViewController.h"


@interface ViewController ()


@end

NSString *name = @"123";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];






    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
