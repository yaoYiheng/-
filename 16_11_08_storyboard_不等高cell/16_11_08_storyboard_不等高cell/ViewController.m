//
//  ViewController.m
//  16_11_08_storyboard_不等高cell
//
//  Created by 姚懿恒 on 2016/11/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHStatusCell.h"
#import "YHStatus.h"
#import "MJExtension.h"

@interface ViewController ()
/** 微博数据*/
@property (nonatomic, strong) NSArray *statusData;

@end

@implementation ViewController
- (NSArray *)statusData{
    if (!_statusData) {
        _statusData = [YHStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    return _statusData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //通过以下方法设置自动计算cell高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.tableView.estimatedRowHeight = 55;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.statusData.count;
}
NSString * ID = @"status";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{



    YHStatusCell *statusCell = [tableView dequeueReusableCellWithIdentifier:ID];

    statusCell.status = self.statusData[indexPath.row];

    return statusCell;

}
//YHStatusCell *statusCell;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    // 传递模型, 布局子控件
//
//    if (!statusCell) {
//        statusCell = [tableView dequeueReusableCellWithIdentifier:ID];
//    }
//    statusCell.status = self.statusData[indexPath.row];
//
//    return statusCell.cellHeight;
//
//
//}
@end
