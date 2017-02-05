//
//  ViewController.m
//  17_02_05_NSCache的基本使用
//
//  Created by 姚懿恒 on 2017/2/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSCacheDelegate>

@property (nonatomic, strong) NSCache *caches;

@end

@implementation ViewController
- (NSCache *)caches{
    if (!_caches) {
        _caches = [[NSCache alloc] init];
        _caches.totalCostLimit = 5;//总成本数是5 ,如果发现存的数据超过中成本那么会自动回收之前的对象
        _caches.delegate = self;

    }
    return _caches;
}


/**
 存数据
 */
- (IBAction)addClick:(id)sender {
    for (int i = 0; i < 10 ; i++) {
        NSData *data = [NSData dataWithContentsOfFile:@"/Users/Morris/Desktop/test.png"];
        //cost:成本
        [self.caches setObject:data forKey:@(i) cost:1];
        NSLog(@"存数据%zd",i);
    }


}

/**
 取数据
 */
- (IBAction)checkClick:(id)sender {
    for (int i = 0; i < 10; i++) {
        NSData *data = [self.caches objectForKey:@(i)];
        if (data) {
            NSLog(@"取出数据%d", i);
        }
    }

}

/**
 删除所有缓存数据
 */
- (IBAction)removeClick:(id)sender {
    [self.caches removeAllObjects];
}


/**
 将要清除缓存是会来到该代理方法

 @param cache <#cache description#>
 @param obj <#obj description#>
 */
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{

    NSLog(@"%lu被清理", (unsigned long)[obj length]);
}


@end
