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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - lazy loading

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

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //取出模型
    YYHAppItem *appItem = self.dataArray[indexPath.row];

    //根据模型设置cell
    cell.textLabel.text = appItem.name;
    cell.detailTextLabel.text = appItem.download;

    //尝试从内存缓存中获取图片
    UIImage *iconImage = self.images[appItem.icon];
    if (iconImage) {
        cell.imageView.image = iconImage;
    }
    else{
    //从网络下载图片
    NSURL *url = [NSURL URLWithString:appItem.icon];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    iconImage = [UIImage imageWithData:imageData];
        //设置到cell
    cell.imageView.image = iconImage;

    //如果内存中没有就将图片根据键保存到字典中.
    [self.images setObject:iconImage forKey:appItem.icon];

    }




    return cell;
}

@end
