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
#import "MJExtension.h"
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
//
//        NSMutableArray *temp = [NSMutableArray array];
//        for (NSDictionary *tgInDict in dataInBundle) {
//            YHTgCell *tgCell = [[YHTgCell alloc] initWithDictionary:tgInDict];
//            [temp addObject:tgCell];
//        }
//        _dataArray = temp;

        //传入字典数组, 可能是从网络上获取的, 可以调用以下方法.
        //通过字典数组来创建一个模型数组

        _dataArray = [YHTgCell mj_objectArrayWithKeyValuesArray:dataInBundle];


        //调用该方法传入 plist文件路径 返回一个装有 调用该方法的模型 的数组.

        _dataArray = [YHTgCell mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil]];

        //调用该方法 传入 plist文件 返回一个装有 调用该方法的模型 的数组.

        _dataArray = [YHTgCell mj_objectArrayWithFilename:@"tgs.plist"];


    }
    return _dataArray;
}
@end
