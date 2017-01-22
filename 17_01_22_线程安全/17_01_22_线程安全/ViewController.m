//
//  ViewController.m
//  17_01_22_线程安全
//
//  Created by 姚懿恒 on 2017/1/22.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** <#comments#>*/
@property (nonatomic, strong) NSThread *threadA;
@property (nonatomic, strong) NSThread *threadB;
@property (nonatomic, strong) NSThread *threadC;
/** <#comments#>*/
@property (nonatomic, assign) NSInteger totalCount;

/** <#comments#>*/
@property (nonatomic, assign) int countA;
/** <#comments#>*/
@property (nonatomic, assign) int countB;
/** <#comments#>*/
@property (nonatomic, assign) int countC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.threadA = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];

    self.threadB = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];

    self.threadC = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];

    self.threadA.name = @"售票员A";
    self.threadB.name = @"售票员B";
    self.threadC.name = @"售票员C";

    self.threadC.threadPriority = 1.0;
    self.threadA.threadPriority = 0.1;
    self.threadB.threadPriority = 0.1;



    [self.threadA start];
    [self.threadB start];
    [self.threadC start];

    self.totalCount = 100;

}
- (void)sale{


    while (true) {

        if ([[NSThread currentThread].name isEqualToString:@"售票员A"]) {
            self.countA +=1;
        }
        else if ([[NSThread currentThread].name isEqualToString:@"售票员B"]){
            self.countB +=1;
        }
        else{
            self.countC +=1;
        }

        /**
            为了防止多条线程访问同一块资源而导致的数据错乱问题, 可以为线程添加互斥锁@synchronized (self).
         互斥锁注意点:
            1. 锁对象必须是全局唯一的.
            2. (使用前提)只有当多条线程共同访问同一资源时, 才需要用到互斥锁.
            3. 注意加锁的位置.
            4. 加锁会造成线程同步.
         
         线程同步的意思是：多条线程在同一条线上执行（按顺序地执行任务）

         */

        @synchronized (self) {

            self.totalCount -= 1;

            for (int i = 0; i < 100000; i++) {

            }
            if (self.totalCount >= 0) {
                NSLog(@"%@卖出来一张票, 还剩%ld张", [NSThread currentThread].name, self.totalCount);
            }
            else{

                NSLog(@"A卖了%d, B卖了%d, C卖了%d", self.countA, self.countB, self.countC);
                break;
            }
            
        }
    }



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
