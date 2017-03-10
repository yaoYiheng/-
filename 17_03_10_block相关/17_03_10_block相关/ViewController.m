//
//  ViewController.m
//  17_03_10_block相关
//
//  Created by 姚懿恒 on 2017/3/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"


/**
 使用typedef定义了一个ReturnString类型的 block
 */
typedef NSString *(^ReturnString)(NSString * , NSString *);

@interface ViewController ()
/** 声明了一个变量名为myblock的block, 该block的类型是接收两个int 参数, 返回值也为int的block*/
@property (nonatomic, strong) int(^myblock)(int, int);

/** 自定义block*/
@property (nonatomic, strong) ReturnString returnBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //block的声明与定义: 返回值类型(^block变量名)(参数1, 参数2,...)
    NSString *(^returnString)(NSString * , NSString *) = ^(NSString *str1, NSString *str2){
        NSMutableString *newStr = [NSMutableString string];

        [newStr appendString:str1];
        [newStr appendFormat:@"123%@", str2];

        return newStr;
    };

    //block的声明
    NSString *(^returnString1)(NSString * , NSString *);

    //通过typedef, 定义了一个需要传入两个string对象作为参数, 返回值为string, 类型为ReturnString, 变量名为returnBlock 的block
    self.returnBlock = ^(NSString *str1, NSString *str2){
        NSMutableString *newStr = [NSMutableString string];

        [newStr appendString:str1];
        [newStr appendFormat:@"123%@", str2];

        return newStr;
    };

    // block快捷方式 inline
    //    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
    //        <#statements#>
    //    };


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@", self.returnBlock(@"zhangmm", @"chibaba"));

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
