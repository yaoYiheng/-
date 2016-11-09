//
//  ViewController.m
//  16_11_09_UITableView刷新数据
//
//  Created by 姚懿恒 on 2016/11/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHWine.h"
#import "YHWineCell.h"
#import "MJExtension.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDataSource>

/** 酒模型数组*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *wineArray;
@end

@implementation ViewController

- (NSArray *)wineArray{
    if (!_wineArray) {
        _wineArray = [YHWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}
    NSString *ID = @"wine";
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerClass:[YHWineCell class] forCellReuseIdentifier:ID];

}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHWineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YHWineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.wine = self.wineArray[indexPath.row];
    return cell;;
}
- (IBAction)addOrRefreshOrDelete:(UIBarButtonItem *)sender {
    NSLog(@"%@", sender);
}

@end
