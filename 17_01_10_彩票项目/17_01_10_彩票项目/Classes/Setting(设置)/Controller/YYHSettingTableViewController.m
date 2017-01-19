//
//  YYHSettingTableViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHSettingTableViewController.h"
#import "YYHCellItem.h"
#import "YYHItemInCellArray.h"
#import "MJExtension.h"
#import "YYHSettingCellTableViewCell.h"

@interface YYHSettingTableViewController ()

/** 数组数据*/
@property (nonatomic, strong) NSArray *cellDataArray;

@end

@implementation YYHSettingTableViewController

- (NSArray *)cellDataArray{
    if (!_cellDataArray) {

        _cellDataArray = [YYHCellItem mj_objectArrayWithFilename:@"cars.plist"];
    }
    return _cellDataArray;

}

/**
 重写init方法, 外界调用时, 直接返回grouped样式的cell
 */
- (instancetype)init{

    return [self initWithStyle:UITableViewStyleGrouped];
}
static NSString * const reuseID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];


    [self.tableView registerClass:[YYHSettingCellTableViewCell class] forCellReuseIdentifier:reuseID];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    YYHCellItem *items = self.cellDataArray[section];

    return items.arrayForCell.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //创建自定义cell
    YYHSettingCellTableViewCell *cell =  [YYHSettingCellTableViewCell cellWithTableView:tableView];

    //获取数组模型
    YYHCellItem *item = self.cellDataArray[indexPath.section];

    NSDictionary *itemInArray = item.arrayForCell[indexPath.row];


    cell.cellItem = itemInArray;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
