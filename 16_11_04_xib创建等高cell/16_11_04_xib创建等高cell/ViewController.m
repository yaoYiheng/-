//
//  ViewController.m
//  16_11_04_xib创建等高cell
//
//  Created by 姚懿恒 on 2016/11/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHTgCell.h"
#import "YHTableViewCell.h"

@interface ViewController ()

/** 数据数组*/
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController


NSString *ID = @"id";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YHTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.tgCell = self.dataArray[indexPath.row];

    return cell;

}

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
