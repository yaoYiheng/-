//
//  main.m
//  16_10_21_添加plist
//
//  Created by 姚懿恒 on 2016/10/21.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *dataArray = @[@"m1",@"m2", @"m3", @"m4", @"m5", @"m6", @"m7", @"m8"];

        BOOL flag = [dataArray writeToFile:@"/Users/Morris/Documents/plist文件/test.plist" atomically:YES];
        if (flag) {
            NSLog(@"chengg");
        }
    }
    return 0;
}
