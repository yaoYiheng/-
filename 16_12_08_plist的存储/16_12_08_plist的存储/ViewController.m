//
//  ViewController.m
//  16_12_08_plist的存储
//
//  Created by 姚懿恒 on 2016/12/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark 将数据写入到plist文件
- (IBAction)saveBtnClick:(UIButton *)sender {
    //获取想要存放文件的路径数组.
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //拿到存放文件的路径
    NSString *cachePath = pathArray[0];
    //对存放路径进行拼接
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"array.plist"];
    NSArray *array = @[@"手机", @10, @{@"呵呵":@"🙃"}];
    //将数据写入文件.
    [array writeToFile:filePath atomically:YES];

}
#pragma mark 从plist文件中读取数据
- (IBAction)readBtnClick:(UIButton *)sender {

    //获取想要读取文件的路径数组.
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", pathArray);
    //从数组中拿到需要读取的文件的路径
    NSString *cachePath = pathArray[0];
    //拼接读取文件的路径
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"array.plist"];
    NSLog(@"%@",filePath);
    //从文件路径中拿到文件数组.
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", array);
}
#pragma mark 保存偏好设置
- (IBAction)preferenceSave:(id)sender {
    //拿到偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //对偏好进行赋值
    [defaults setObject:@"张mm" forKey:@"name"];
    [defaults setInteger:22 forKey:@"age"];
    //立即写入文件
    [defaults synchronize];
}
#pragma mark 读取偏好设置
- (IBAction)preferenceRead:(id)sender {
    //拿到偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //根据键拿到对应的值
    NSString *name = [defaults objectForKey:@"name"];
    NSInteger age = [defaults integerForKey:@"age"];

    NSLog(@"%@, %ld", name, age);
}

#pragma mark 保存归档文件

/**
 保存自定义对象

 */
- (IBAction)KeyedArchiver:(UIButton *)sender {

    //返回沙盒中temp文件夹的地址.
    NSString *tempPath = NSTemporaryDirectory();
    ///拼接待保存的文件路径
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"Person.data"];
    Person *person = [[Person alloc] init];
    person.name = @"张mm";
    person.age = 22;
    //将对象保存至指定路径
    if([NSKeyedArchiver archiveRootObject:person toFile:filePath]){
        NSLog(@"归档成功");
    }

}

#pragma mark 读取归档文件
- (IBAction)KeyedUnarchiver:(UIButton *)sender {
    //返回沙盒temp文件夹, 并拼接待保存文件路径,
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"Person.data"];
    //拿到保存的对象.
    Person *per = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@---%d", per.name, per.age);
}

@end
