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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [YYHAppItem mj_objectArrayWithFilename:@"apps.plist"];
    }
    return _dataArray;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"app";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //取出模型
    YYHAppItem *appItem = self.dataArray[indexPath.row];

    //根据模型设置cell
    cell.textLabel.text = appItem.name;
    cell.detailTextLabel.text = appItem.download;
    //从网络下载图片
    NSURL *url = [NSURL URLWithString:appItem.icon];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *iconImage = [UIImage imageWithData:imageData];
    
    cell.imageView.image = iconImage;

    return cell;
}

@end
