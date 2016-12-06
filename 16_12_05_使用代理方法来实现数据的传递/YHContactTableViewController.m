//
//  YHContactTableViewController.m
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/1.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHContactTableViewController.h"
#import "YHAddItem.h"
#import "YHAddViewController.h"
#import "YHEditViewController.h"

@interface YHContactTableViewController ()<addViewDelegate>
/** 数据数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YHContactTableViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录", _userName];


}
- (void)setAddItem:(YHAddItem *)addItem{
    _addItem = addItem;
    NSLog(@"%@---%@", addItem.userName, addItem.phoneNumber);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.destinationViewController isKindOfClass:[YHAddViewController class]]) {
        YHAddViewController *addVC = segue.destinationViewController;

        addVC.delegate = self;
    }else{
        YHEditViewController *editVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        YHAddItem *item = self.dataArray[indexPath.row];
        editVC.addItem = item;
    }


}
- (void)addViewController:(YHAddViewController *)addViewController addItem:(YHAddItem *)addItem{

    //调用代理方法, 将带来传入的item添加到数组中
    [self.dataArray addObject:addItem];

    //刷新数据.
    [self.tableView reloadData];
}
- (IBAction)logOut:(UIBarButtonItem *)sender {


    //1.创建一个alertController, 设置其通知标题, 显示的信息, 以及样式.
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];

    //2.创建按钮, 每一个按钮对应不同的action.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        /** <#do someting#>*/

    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];

    //3.将action添加到控制器中.
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];

    //4.显示弹窗
    [self presentViewController:alertController animated:YES completion:nil];

}
#pragma mark actionSheet的代理方法
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//
//}
#pragma mark alertView的代理方法
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

#pragma mark 拿到具体的item返回对应的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"contact";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    YHAddItem * item = self.dataArray[indexPath.row];
    cell.textLabel.text = item.userName;
    cell.detailTextLabel.text = item.phoneNumber;
    cell.imageView.image = [UIImage imageNamed:@"m1.png"];

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
