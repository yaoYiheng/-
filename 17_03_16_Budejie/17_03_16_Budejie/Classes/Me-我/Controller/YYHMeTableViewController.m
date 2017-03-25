//
//  YYHMeTableViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
    搭建 我的 界面
 由静态cell + UICollectionView组成 -> 通过storyboard取描述该页面
 */

#import "YYHMeTableViewController.h"
#import "YYHSettingTableViewController.h"

@interface YYHMeTableViewController ()

@end

@implementation YYHMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *nightButton = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] Target:self action:@selector(nightModel:)];

    UIBarButtonItem *settingButton = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"mine-setting-icon"] hightligtedImage:[UIImage imageNamed:@"mine-setting-icon-click"] Target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems = @[settingButton, nightButton];

    self.navigationItem.title = @"我的";
}

- (void)nightModel:(UIButton *)button{

    button.selected =!button.isSelected;
}

/**
 点击后跳转到setting的控制器
 */
- (void)setting{

    YYHSettingTableViewController *settingVC = [[YYHSettingTableViewController alloc] init];
    //只有在跳转之前设置该属性, 才能在跳转后实现隐藏底部tabBar的效果.
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
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
