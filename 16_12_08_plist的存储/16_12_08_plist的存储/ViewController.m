//
//  ViewController.m
//  16_12_08_plist的存储
//
//  Created by 姚懿恒 on 2016/12/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
