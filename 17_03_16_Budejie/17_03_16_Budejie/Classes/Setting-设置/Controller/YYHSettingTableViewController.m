//
//  YYHSettingTableViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHSettingTableViewController.h"

@interface YYHSettingTableViewController ()

@end

@implementation YYHSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";

//    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [barButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//    [barButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//    [barButton setTitle:@"返回" forState:UIControlStateNormal];
//    [barButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [barButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    barButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
//    [barButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [barButton sizeToFit];
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];

    //在子控制中设置对应子控制器的左边返回按钮(leftBarButtonItem)
    //分析: 参考源程序, 很多界面都有用到返回按钮, 可以考虑将该按钮进行统一设置.-->到自定义的导航控制器中进行设置.
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonWithImage:[UIImage imageNamed:@"navigationButtonReturn"]  hightligtedImage:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self action:@selector(back) title:@"返回"];
}

/**
 点击调回到上一级界面.
 */
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
