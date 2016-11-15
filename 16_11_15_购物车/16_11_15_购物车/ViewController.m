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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 酒数组*/
@property (nonatomic, strong) NSArray *wineDataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

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

    //添加一个观察者，可以为它指定一个方法，名字和对象。接受到通知时，执行方法。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remove:) name:@"removeClickButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add:) name:@"addClickButton" object:nil];
}
#pragma mark 移除观察者
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 观察者需要方法
- (void)remove:(NSNotification *)note{
    YHWineCell *wineCell = note.object;
    int totalPrice = self.totalPriceLabel.text.intValue - wineCell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d", totalPrice];

}
- (void)add:(NSNotification *)note{
    YHWineCell *wineCell = note.object;
    int totalPrice = self.totalPriceLabel.text.intValue + wineCell.wine.money.intValue;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d", totalPrice];
}

#pragma mark UITableViewDataSource数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"wine";

    YHWineCell *wineCell = [self.tableView dequeueReusableCellWithIdentifier:ID];

    wineCell.wine = self.wineDataArray[indexPath.row];

    return wineCell;

}
#pragma mark 代理方法, 选中某一行抽指向的动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
@end
