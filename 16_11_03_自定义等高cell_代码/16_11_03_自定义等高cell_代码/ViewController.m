//
//  ViewController.m
//  16_11_03_自定义等高cell_代码
//
//  Created by 姚懿恒 on 2016/11/3.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *ID = @"id";
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 80;
    [self.tableView registerClass:[YHTableViewCell class] forCellReuseIdentifier:ID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    

    return cell;

}


@end
