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

    [self ocToJSON];
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
