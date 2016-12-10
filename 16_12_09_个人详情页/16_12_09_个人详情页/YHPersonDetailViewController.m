//
//  YHPersonDetailViewController.m
//  16_12_09_个人详情页
//
//  Created by 姚懿恒 on 2016/12/10.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHPersonDetailViewController.h"

@interface YHPersonDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YHPersonDetailViewController


NSString *ID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    cell.textLabel.text = @"张mm";

    return cell;

}

@end
