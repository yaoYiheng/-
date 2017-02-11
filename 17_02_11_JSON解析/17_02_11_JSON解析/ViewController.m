//
//  ViewController.m
//  17_02_11_JSON解析
//
//  Created by 姚懿恒 on 2017/2/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self JSONToOC];
}

- (void)JSONToOC{
    //NSString *strM = @"{\"error\":\"用户名不存在\"}";
    //NSString *strM = @"[\"error\",\"用户名不存在\"]";
    //NSString *strM = @"\"yaoyiheng\"";
    NSString *strM = @"false";
    //NSString *strM = @"true";
//    NSString *strM = @"null";

    //JSON--->oc对象 反序列化
    /*
     第一个参数:JSON的二进制数据
     第二个参数:
     第三个参数:错误信息
     */
    /*
     NSJSONReadingMutableContainers = (1UL << 0), 可变字典和数组
     NSJSONReadingMutableLeaves = (1UL << 1),      内部所有的字符串都是可变的 ios7之后又问题  一般不用
     NSJSONReadingAllowFragments = (1UL << 2)   既不是字典也不是数组,则必须使用该枚举值
     */

    id obj = [NSJSONSerialization JSONObjectWithData:[strM dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:0];
    NSLog(@"%@---%@",[obj class],obj);

    /*
     JOSN   OC
     {}     @{}
     []     @[]
     ""     @""
     false  NSNumber 0
     true   NSNumber 1
     null      NSNull为空
     */

    //nil
    [NSNull null];   //该方法获得的是一个单粒,表示为空,可以用在字典或者是数组中
}

- (void)ocToJSON{

    //将字典转为JSON数据
    NSDictionary *dict = @{@"name": @"pig",
                           @"age" :@23};
    /*
     第一个参数:要转换的OC对象
     第二个参数:选项NSJSONWritingPrettyPrinted 排版 美观
     */
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];

    NSLog(@"%@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);

    //将数组转为JSON数据
    NSArray *array = @[@"123",@"234"];
    NSData *data2 = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];

    NSLog(@"%@", [[NSString alloc]initWithData:data2 encoding:NSUTF8StringEncoding]);

    //将字符串转为JSON数据, 并不能将字符串转为JSON数据
    /*
     - Top level object is an NSArray or NSDictionary
     - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
     - All dictionary keys are NSStrings
     - NSNumbers are not NaN or infinity
     
     - 最外层必须是 NSArray or NSDictionary
     - 所有的元素必须是 NSString, NSNumber, NSArray, NSDictionary, or NSNull
     - 字典中所有的key都必须是 NSStrings类型的
     - NSNumbers不能死无穷大
     */

    NSString *string = @"hahahha";
    if(![NSJSONSerialization isValidJSONObject:string] ){

        NSLog(@"该类型不能转化为JSON数据");
        return;
    }
    NSData *data3 = [NSJSONSerialization dataWithJSONObject:string options:NSJSONWritingPrettyPrinted error:nil];

    NSLog(@"%@", [[NSString alloc]initWithData:data3 encoding:NSUTF8StringEncoding]);

}

@end
