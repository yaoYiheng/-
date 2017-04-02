//
//  YYHBasicTableViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/31.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHBasicTableViewController.h"

@interface YYHBasicTableViewController ()

@end

@implementation YYHBasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YYHRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(YYHTitleViewHeight + YYHNaviBarMaxY, 0, YYHTabBarHeight, 0);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDoubleClick) name:YYHTabBarButtonDidDoubleClickNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:YYHTitleButtonDidDoubleClickNotification object:nil];

}

-(void)dealloc{
    //从通知中心中移除观察者
    YYHFunc
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarButtonDoubleClick{

    if (self.view.window == nil) return;

    if (self.tableView.scrollsToTop == NO) return;

    NSLog(@"%@刷新数据%s", self.class, __func__);

}
/**
 *  监听titleButton重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDoubleClick];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}
@end
