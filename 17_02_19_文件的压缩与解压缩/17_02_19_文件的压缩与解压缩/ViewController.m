//
//  ViewController.m
//  17_02_19_文件的压缩与解压缩
//
//  Created by 姚懿恒 on 2017/2/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

#import "SSZipArchive.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self unZip];
}

- (void)zip{
//    /Users/Morris/Documents/图形文件/
    //Users/Morris/Documents/图形文件/阿银/银魂1.jpg
    ///Users/Morris/Documents/图形文件/阿银/Gin_2.jpg
    NSArray *array = @[@"/Users/Morris/Documents/图形文件/阿银/银魂1.jpg",
                       @"/Users/Morris/Documents/图形文件/阿银/Gin_2.jpg"];

    /*
     该方法将压缩文件创建到指定路径, 将待压缩文件路径保存到数组中.

     第一个参数:压缩文件的存放位置
     第二个参数:要压缩哪些文件(路径)

     */
    [SSZipArchive createZipFileAtPath:@"/Users/Morris/Documents/图形文件/test.zip" withFilesAtPaths:array];

    /*
     该方法能够压缩指定文件夹
     第一个参数:压缩文件存放位置
     第二个参数:要压缩的文件夹(目录)
     */
    [SSZipArchive createZipFileAtPath:@"/Users/Morris/Documents/图形文件/阿银.zip" withContentsOfDirectory:@"/Users/Morris/Documents/图形文件/阿银"];

    NSArray *array1 = @[@"/Users/Morris/Documents/图形文件/阿银"];

    /*
     创建一个有密码的压缩文件
     */
    [SSZipArchive createZipFileAtPath:@"/Users/Morris/Documents/图形文件/阿银.zip"  withFilesAtPaths:array1 withPassword:@"123456"];
}
- (void)unZip{
    /*
     第一个参数:要解压的文件在哪里
     第二个参数:文件应该解压到什么地方
     */
    [SSZipArchive unzipFileAtPath:@"/Users/Morris/Documents/图形文件/test.zip" toDestination:@"/Users/Morris/Documents/图形文件/test" progressHandler:^(NSString *entry, unz_file_info zipInfo, long entryNumber, long total) {
        //当前解压的文件个数, 总个数
        NSLog(@"已解压完%zd个文件, 共%zd个文件", entryNumber, total);
    } completionHandler:nil];
}

@end
