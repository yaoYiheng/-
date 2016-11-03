//
//  ViewController.m
//  16_11_03_自定义等高cell_代码
//
//  Created by 姚懿恒 on 2016/11/3.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHTableViewCell.h"
#import "YHTgCell.h"

@interface ViewController ()

/** 数据*/
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

NSString *ID = @"id";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 80;
    //注册标识
    [self.tableView registerClass:[YHTableViewCell class] forCellReuseIdentifier:ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.tgCell = self.dataArray[indexPath.row];

    return cell;
}
//懒加载数组
- (NSArray *)dataArray{
    if (!_dataArray) {

        NSArray *dataInBundle = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil]];

        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *tgInDict in dataInBundle) {
            YHTgCell *tgCell = [[YHTgCell alloc] initWithDictionary:tgInDict];
            [temp addObject:tgCell];
        }
        _dataArray = temp;
    }
    return _dataArray;
}


@end
