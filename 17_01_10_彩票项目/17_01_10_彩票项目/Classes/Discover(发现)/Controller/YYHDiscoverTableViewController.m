//
//  YYHDiscoverTableViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHDiscoverTableViewController.h"

@interface YYHDiscoverTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *cell;

@end

@implementation YYHDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 每次view将要出现都会来到该方法.
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //性能消耗大, 不推荐使用.
    [self.tableView reloadData];


}

/**
 数据源方法.
 重新刷新数据.
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //先使View移除到屏幕外
    cell.transform = CGAffineTransformMakeTranslation(self.view.Width, 0);
    //在调用动画使其回位.
    [UIView animateWithDuration:0.5 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

@end
