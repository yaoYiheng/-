//
//  ViewController.m
//  16_11_15_购物车
//
//  Created by 姚懿恒 on 2016/11/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHWine.h"
#import "YHWineCell.h"
#import "MJExtension.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, YHWineCellDelegate>

/** 酒数组*/
@property (nonatomic, strong) NSArray *wineDataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation ViewController

#pragma mark 懒加载数组
- (NSArray *)wineDataArray{
    if (!_wineDataArray) {
        _wineDataArray = [YHWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineDataArray;
}
#pragma mark 加载控制器的view, 在该方法中完成操作一次的设置
- (void)viewDidLoad {
    [super viewDidLoad];


}

#pragma mark UITableViewDataSource数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"wine";

    YHWineCell *wineCell = [self.tableView dequeueReusableCellWithIdentifier:ID];

    wineCell.wine = self.wineDataArray[indexPath.row];

    wineCell.delegate = self;

    return wineCell;

}
#pragma mark 代理方法, 选中某一行抽指向的动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark 处理结算功能与清空功能
- (IBAction)buy {
    //变量数组中所有元素, 如果count不为零, 则打印购买内容
    for (YHWine *wine in self.wineDataArray) {
        if (wine.count) {
            NSLog(@"购买了%d份%@", wine.count, wine.name);
        }
    }
}
- (IBAction)clear {

    self.totalPriceLabel.text = @"0";
    self.buyButton.enabled = NO;
    self.clearButton.enabled = NO;
    for (YHWine *wine in self.wineDataArray) {
        wine.count = 0;
    }
    [self.tableView reloadData];
}

#pragma mark YHWineCellDelegate方法
- (void)wineCellDidClickAddButton:(YHWineCell *)wineCell{
    int totalPrice;
    totalPrice = self.totalPriceLabel.text.intValue + wineCell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d", totalPrice];

    self.clearButton.enabled = YES;
    self.buyButton.enabled = YES;
}

- (void)wineCellDidClickMinusButton:(YHWineCell *)wineCell{
    int totalPrice;
    totalPrice = self.totalPriceLabel.text.intValue + wineCell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d", totalPrice];

    self.clearButton.enabled = wineCell.wine.count > 0;
    self.buyButton.enabled = wineCell.wine.count > 0;
}


@end
