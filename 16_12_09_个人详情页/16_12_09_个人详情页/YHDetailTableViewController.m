//
//  YHDetailTableViewController.m
//  16_12_09_个人详情页
//
//  Created by 姚懿恒 on 2016/12/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHDetailTableViewController.h"

@interface YHDetailTableViewController ()


@end

@implementation YHDetailTableViewController

static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];

    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
    //只要在导航条下面, 就会自动设置偏移量
    //调用以下方法可禁止.
    self.automaticallyAdjustsScrollViewInsets = NO;


    //为navigationBar 设置一张为空的图片.forBarMetrics:设置为UIBarMetricsDefault.
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    //为导航栏下放的阴影传一张空图片
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    header.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = header;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //使用该方法拿到循环利用的cell需在一开始时注册, 或在storyboard中填写标识.二者任选其一, 目前还未发现两者都写会有什么影响, 在http://www.jianshu.com/p/6fa93cec67f2 中有提到使用storyboard，在绘制的时候就已注册，不能再另外调用registerClass，否则创建的cell会不显示, 不知是不是?
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];

    cell.textLabel.text = @"张mm";
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
