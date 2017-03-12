//
//  CaculatorManager.m
//  17_03_12_block作为参数使用
//
//  Created by 姚懿恒 on 2017/3/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "CaculatorManager.h"

@implementation CaculatorManager

- (void)caculate:(NSInteger (^)(NSInteger))caculatorBlock{

//    caculatorBlock = ^NSInteger(NSInteger result) {
//        result += 12;
//        result *= 2;
//
//        return result;
//    };
    if (caculatorBlock) {
       _result = caculatorBlock(_result);
    }
}
- (void)returnAString:(NSString *(^)(NSString *, NSString *))newString{

    
    if (newString) {

        _returnedString = newString(_returnedString, _returnedString);
    }
}


@end
