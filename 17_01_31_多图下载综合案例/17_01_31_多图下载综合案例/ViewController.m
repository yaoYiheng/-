//
//  ViewController.m
//  17_01_31_多图下载综合案例
//
//  Created by 姚懿恒 on 2017/1/31.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YYHAppItem.h"
#import "MJExtension.h"

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, strong) NSArray *dataArray;

/** 图片字典*/
@property (nonatomic, strong) NSMutableDictionary *images;
/** 操作队列*/
@property (nonatomic, strong) NSOperationQueue *queue;
/** 操作缓存*/
@property (nonatomic, strong) NSMutableDictionary *operations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject);
}

#pragma mark - lazy loading
- (NSMutableDictionary *)operations{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}
- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

- (NSMutableDictionary *)images{
    if (!_images) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [YYHAppItem mj_objectArrayWithFilename:@"apps.plist"];
    }
    return _dataArray;
}
#pragma mark dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
#pragma mark tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"app";
    __block NSData *imageData;
    __block UIImage *iconImage;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //取出模型
    YYHAppItem *appItem = self.dataArray[indexPath.row];

    //根据模型设置cell
    cell.textLabel.text = appItem.name;
    cell.detailTextLabel.text = appItem.download;


    //获取cache路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //调用lastPathComponent该方法, 获取地址的最后 图片的名称
    NSString *fileName = [appItem.icon lastPathComponent];
    //拼接图片名
    NSString *filePath = [path stringByAppendingPathComponent:fileName];

    //尝试从内存缓存中获取图片
    iconImage = self.images[appItem.icon];

    if (iconImage) {
        cell.imageView.image = iconImage;
    }
    else{
        //1. 如果图片存在于沙盒中, 就从沙盒中获取数据
        imageData  = [NSData dataWithContentsOfFile:filePath];
        imageData = nil;

        if (imageData) {
            iconImage = [UIImage imageWithData:imageData];
            //设置到cell
            cell.imageView.image = iconImage;

            //内存中没有就将图片根据键保存到字典中.
            [self.images setObject:iconImage forKey:appItem.icon];
        }
        //2. 如果没有, 就从网络下载
        else{
            //先检查缓存池中是否已存在下载操作, 如果存在下载操作, 就什么也不做

            NSBlockOperation *download = [self.operations objectForKey:appItem.icon];
            if (download) {

            }
            else{

                //为了防止数据错乱, 可以先为cell设置站位图片
                cell.imageView.image = [UIImage imageNamed:@"test"];

                download = [NSBlockOperation blockOperationWithBlock:^{
                    //从网络下载图片
                    NSURL *url = [NSURL URLWithString:appItem.icon];
                    imageData = [NSData dataWithContentsOfURL:url];
                    iconImage = [UIImage imageWithData:imageData];

                    //在这里判断图片文件是否有效,
                    //t0125e8d 图片名
                    if (!iconImage) {
                        [self.operations removeObjectForKey:appItem.icon];
                        return;
                    }

                    [imageData writeToFile:filePath atomically:YES];


                    /**内存中没有就将图片根据键保存到字典中.
                    注意: 将下载的图片添加到缓存中的操作应该放到刷新表格之前.

                    */
                    [self.images setObject:iconImage forKey:appItem.icon];

                    //设置到cell
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{

                        //                    cell.imageView.image = iconImage;

                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
                    }];

                    //将图片数据写入到沙盒


                    //移除操作
                    [self.operations removeObjectForKey:appItem.icon];
                }];
                //添加操作到缓存
                [self.operations setObject:download forKey:appItem.icon];
                [self.queue addOperation:download];
                

            }


        }
}




    return cell;
}

@end
