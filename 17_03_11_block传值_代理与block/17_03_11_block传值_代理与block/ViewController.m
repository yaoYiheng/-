//
//  ViewController.m
//  17_03_11_block传值_代理与block
//
//  Created by 姚懿恒 on 2017/3/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
@interface ViewController ()
@property (nonatomic, copy) void(^myBlock)();
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MRCandARC];
}

/**

     block是不是一个对象?是一个对象

     如何判断当前文件是MRC,还是ARC
     1.dealloc 能否调用super,只有MRC才能调用super
     2.能否使用retain,release.如果能用就是MRC

     ARC管理原则:只要一个对象没有被强指针修饰就会被销毁,默认局部变量对象都是强指针,存放到堆里面

     MRC了解开发常识:1.MRC没有strong,weak,局部变量对象就是相当于基本数据类型
     2.MRC给成员属性赋值,一定要使用set方法,不能直接访问下划线成员属性赋值

     总结:只要block没有引用外部局部变量,block放在全局区(__NSGlobalBlock__)

     MRC:管理block
     只要Block引用外部局部变量,block放在栈里面(在没有为成员属性赋值的情况下, 在方法中的时候__NSStackBlock__).
     block只能使用copy,不能使用retain,使用retain,block还是在栈里面


     ARC:管理block
     只要block引用外部局部变量,block放在堆里面
     block使用strong.最好不要使用copy
 
 

      如果是局部变量,Block是值传递

      如果是静态变量,全局变量,__block修饰的变量,block都是指针传递
 */

- (void)MRCandARC{
    int a = 1;
//    self.myBlock = ^{
//        NSLog(@"调用block%@--- %d",_myBlock, a);
//    };
//
//    self.myBlock = ^{
//        NSLog(@"%@", self.myBlock);
//    };
//
//    void(^myBlock)() = ^{
//        NSLog(@"%@", myBlock);
//    };
//    self.myBlock = myBlock;

    void(^block)() = ^{

        NSLog(@"调用block");
    };
    self.myBlock = block;

    NSLog(@"%@-----%@",block, self.myBlock);
}

/**
 如何判断当前文件是MRC,还是ARC
 1.dealloc 能否调用super,只有MRC才能调用super
 2.能否使用retain,release.如果能用就是MRC
 */
- (void)dealloc{
    [super dealloc];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    self.myBlock();


}

- (void)modalVC{
    //点击控制器后跳转到Modal控制器
    ModalViewController *modalVC = [[ModalViewController alloc] init];
    modalVC.view.backgroundColor = [UIColor orangeColor];
    //    modalVC.delegate = self;

    //对myBlock进行定义
    modalVC.myBlock = ^(NSString *value){
        NSLog(@"%@", value);
    };

    [self presentViewController:modalVC animated:YES completion:nil];
}
//- (void)modalViewController:(ModalViewController *)modalViewController sendingValue:(NSString *)value{
//    NSLog(@"%@", value);
//}

@end
