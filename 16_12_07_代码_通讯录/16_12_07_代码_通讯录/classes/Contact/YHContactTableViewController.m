//
//  YHContactTableViewController.m
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHContactTableViewController.h"
#import "YHAddContactViewController.h"
#import "YHContactItems.h"
#import "YHEditViewController.h"

@interface YHContactTableViewController ()<AddContactDelegate>
/** 用来装模型的数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YHContactTableViewController

#pragma mark 懒加载数组
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"%@的通讯录", self.userName];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:0 target:self action:@selector(logOut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:0 target:self action:@selector(addContact)];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:@"textChanged" object:nil];

}
- (void)textChange{
    [self.tableView reloadData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 注销功能
- (void)logOut{
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"确定退出吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alerActionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    //点击确定, 返回上一级登录界面
    UIAlertAction *alerActionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alerController addAction:alerActionCancel];
    [alerController addAction:alerActionConfirm];
    //调用控制器其的 方法显示警告弹框
    [self presentViewController:alerController animated:YES completion:nil];

}
#pragma mark 点击添加按钮
- (void)addContact{

    YHAddContactViewController *addContatViewController = [[YHAddContactViewController alloc] init];
    addContatViewController.delegate = self;
    //跳转到添加界面
    [self.navigationController pushViewController:addContatViewController animated:YES];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
#pragma mark AddContactDelegate代理方法.
- (void)addContactViewController:(YHAddContactViewController *)contactView contactItem:(YHContactItems *)contactItem{
    [self.dataArray addObject:contactItem];
    //刷新表格数据
    [self.tableView reloadData];

    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"contact";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    YHContactItems *contactItem = self.dataArray[indexPath.row];
    cell.textLabel.text = contactItem.name;
    cell.detailTextLabel.text = contactItem.phone;
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHEditViewController *editViewController = [[YHEditViewController alloc] init];
    YHContactItems *contactItem = self.dataArray[indexPath.row];
    editViewController.contactItem = contactItem;
    [self.navigationController pushViewController:editViewController animated:YES];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
