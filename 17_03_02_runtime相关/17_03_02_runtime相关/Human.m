//
//  Human.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/2.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "Human.h"

@implementation Human
- (void)eat{
    NSLog(@"%s", __func__);
}

- (void)run:(NSInteger)meter{
    NSLog(@"跑了%ldkm", meter);
}
@end
