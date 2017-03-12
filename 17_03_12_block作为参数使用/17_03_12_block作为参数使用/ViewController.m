//
//  ViewController.m
//  17_03_12_block作为参数使用
//
//  Created by 姚懿恒 on 2017/3/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "CaculatorManager.h"
@interface ViewController ()

/*
     Q:如何区分参数是不是block?
     A:就看有没有^, 只要有^ 就把block当做参数

     把block当做参数,并不是马上就调用Block,什么时候调用,由方法内部决定
     什么时候需要把block当做参数去使用:做的事情由外界决定,但是什么时候做由内部决定.


 需求:封装一个计算器,提供一个计算方法,怎么计算由外界决定,什么时候计算由内部决定.

 */

@property (nonatomic, strong) CaculatorManager *mgr;
@end

@implementation ViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    CaculatorManager *mgr = [CaculatorManager new];
    [mgr returnAString:^NSString *(NSString *str1, NSString *str2) {
        str1 = @"张mm";
        str2 = @"呵呵";

        return [NSString stringWithFormat:@"%@----->%@", str1, str2];
    }];
    self.mgr = mgr;


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CaculatorManager *mgr = [CaculatorManager new];



    /*
     在这里相当于调用 caculate 该方法, 并把{}内的代码, 作为参数传递给caculatorBlock
//     */
//    [mgr caculate:^NSInteger(NSInteger result) {
//        result += 12;
//        result *= 2;
//
//        return result;
//    }];

    [mgr caculate:^NSInteger(NSInteger result) {
        result +=100;
        result *= 2;
        return result;
    }];
    NSLog(@"%ld", mgr.result);

    NSLog(@"%@",self.mgr.returnedString);

}

@end
