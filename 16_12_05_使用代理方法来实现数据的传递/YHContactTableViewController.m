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

@interface YHContactTableViewController ()<addViewDelegate, EditViewDelegate>
/** 数据数组*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YHContactTableViewController

#pragma mark 懒加载数组.
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark 控制器加载完毕来带此方法, 完成一些初始化的操作.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录", _userName];


}

#pragma mark 通过segue拿到目标控制器, 在跳转前完成代理的设置或者值的传递.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    //如果目标控制器是YHAddViewController, 则拿到YHAddViewController控制器, 并设置其代理.
    if ([segue.destinationViewController isKindOfClass:[YHAddViewController class]]) {
        YHAddViewController *addVC = segue.destinationViewController;

        addVC.delegate = self;
    }else{
        //如果目标控制器是编辑控制器, 则设置其代理, 并拿到所点击的那一行的item并传给编辑控制器
        YHEditViewController *editVC = segue.destinationViewController;
        editVC.delegate = self;
        //调用indexPathForSelectedRow拿到所点击那一个行的indexPath
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //通过对应的indexPath从数组中拿到对应的item
        YHAddItem *item = self.dataArray[indexPath.row];
        //为编辑控制器中的item赋值.
        editVC.addItem = item;
    }


}
#pragma mark addViewDelegate的代理方法.在该方法中拿到 <添加编辑器> 传来的数据模型
- (void)addViewController:(YHAddViewController *)addViewController addItem:(YHAddItem *)addItem{

    //调用代理方法, 将带来传入的item添加到数组中
    [self.dataArray addObject:addItem];

    //刷新数据.
    [self.tableView reloadData];

    //设置tableFooterView, 取消空白处分割线.
    self.tableView.tableFooterView = [[UIView alloc] init];
}
#pragma mark EditViewDelegate代理方法, 拿到 <编辑控制器> 传入的新值, 并刷新.
- (void)edittingViewController:(YHEditViewController *)editingViewController addItem:(YHAddItem *)additem{
    [self.tableView reloadData];
}
#pragma mark 注销功能的实现
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


#pragma mark UITableView的代理方法, 返回显示多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

#pragma mark 拿到具体的item返回对应的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"contact";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    YHAddItem * item = self.dataArray[indexPath.row];
    cell.textLabel.text = item.userName;
    cell.detailTextLabel.text = item.phoneNumber;
    cell.imageView.image = [UIImage imageNamed:@"m1.png"];

    return cell;

}



@end
