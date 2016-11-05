//
//  ViewController.m
//  16_11_05_自定义不等高cell
//
//  Created by 姚懿恒 on 2016/11/5.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHStatus.h"
#import "YHStatuesCell.h"
#import "MJExtension.h"

@interface ViewController ()
/** 微博数据数组*/
@property (nonatomic, strong) NSArray *statusData;

@end

@implementation ViewController

NSString *ID = @"weibo";

- (NSArray *)statusData{
    if (!_statusData) {
        _statusData = [YHStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    return _statusData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[YHStatuesCell class] forCellReuseIdentifier:ID];
    NSLog(@"%@", _statusData);
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.statusData.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YHStatuesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.statuses = self.statusData[indexPath.row];

    return cell;
}

@end
