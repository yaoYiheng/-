//
//  YHPersonDetailViewController.m
//  16_12_09_个人详情页
//
//  Created by 姚懿恒 on 2016/12/10.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHPersonDetailViewController.h"
#define imageViewHeight 200
#define originalOffsetY 244

@interface YHPersonDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraints;

@end

@implementation YHPersonDetailViewController


NSString *ID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
//    headerView.backgroundColor = [UIColor lightGrayColor];
//    self.tableView.tableHeaderView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(originalOffsetY, originalOffsetY, 0, 0);

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f", scrollView.contentOffset.x);

    CGFloat offsetBetweenImageViewAndTabel =  originalOffsetY + scrollView.contentOffset.y ;


    CGFloat currentHeightOfImageView = imageViewHeight - offsetBetweenImageViewAndTabel;
    if (currentHeightOfImageView < 64) {
        currentHeightOfImageView = 64;
    }
    self.imageViewHeightConstraints.constant = currentHeightOfImageView;
    NSLog(@"%f", offsetBetweenImageViewAndTabel);
}


@end
