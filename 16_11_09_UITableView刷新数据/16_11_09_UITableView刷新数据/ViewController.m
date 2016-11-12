//
//  ViewController.m
//  16_11_09_UITableView刷新数据
//
//  Created by 姚懿恒 on 2016/11/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHWine.h"
#import "YHWineCell.h"
#import "MJExtension.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 酒模型数组*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (nonatomic, strong) NSMutableArray *wineArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;

/** 选中的元素的indexPath*/
@property (nonatomic, strong) NSMutableArray *selectedIndexPath;
@end

@implementation ViewController
#pragma mark 懒加载wineArray, indexPath数组
- (NSMutableArray *)wineArray{
    if (!_wineArray) {
        _wineArray = [YHWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}

- (NSMutableArray *)selectedIndexPath{
    if (!_selectedIndexPath) {
        _selectedIndexPath = [NSMutableArray array];
    }
    return _selectedIndexPath;
}
    NSString *ID = @"wine";

#pragma mark 一些全局只需要设置一次的操作在该方法中完成
- (void)viewDidLoad {
    [super viewDidLoad];

    //调用该属性允许在进入编辑模式时选择多行
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    self.deleteButton.enabled = NO;
}
#pragma mark 调用数据源方法确定行数以及返回每行对应的cell
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHWineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YHWineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.wine = self.wineArray[indexPath.row];
    return cell;
}

#pragma mark 实现选中与删除功能
- (IBAction)delete:(UIBarButtonItem *)sender
{
    //创建一个数组用来保存选中的元素
    NSMutableArray *selectedItems = [NSMutableArray array];

    //变量所选中行的 indexPath, 并通过indexPath拿到所对应的模型, 并添加到数组中.
    for (NSIndexPath *indextPath in self.tableView.indexPathsForSelectedRows) {

        [selectedItems addObject:self.wineArray[indextPath.row]];

    }
    //调用 removeObjectsInArray:方法 从数组中删除 保存元素的数组
    [self.wineArray removeObjectsInArray:selectedItems];

    //调用 deleteRowsAtIndexPaths:方法 从tableView中删除对应的cell(完成刷新)
    [self.tableView deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationAutomatic];


}
- (IBAction)customDelete:(UIBarButtonItem *)sender
{
    //创建一个临时数组用来装待删除的元素
    NSMutableArray *deletedWine = [NSMutableArray array];

    //变量indexPath数组, 将在数组内的元素添加到deletedWine数组中
    for (NSIndexPath *indexPath in self.selectedIndexPath) {
        [deletedWine addObject:self.wineArray[indexPath.row]];
    }
    //从模型数组中删除待删除的元素的数组.
    [self.wineArray removeObjectsInArray:deletedWine];

    //刷新cell
    [self.tableView deleteRowsAtIndexPaths:self.selectedIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];

    //完成删除操作后, 将之前装有选中项目的indexPath的数组清空.
    [self.selectedIndexPath removeAllObjects];

    //使按钮变得不可用.
    self.refresh.enabled = NO;



}

- (IBAction)multiDelete:(UIBarButtonItem *)sender {

    //设置进入编辑模式 是否进入编辑模式取决于tableView是否处于编辑模式.
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];

    //根据是否进入编辑模式判断按钮是否可用
    self.deleteButton.enabled =self.tableView.editing;

}

//#pragma mark 调用该代理方法, 就能实现向左滑动出现删除按钮功能
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    //通过修改模型数据达到修改界面的目的. 删除所选择的那一行.
//    [self.wineArray removeObjectAtIndex:indexPath.row];
//
//    /**在数组中删除模型后, 需对tableView进行刷新, 
//     这里使用deleteRowsAtIndexPaths:进行局部刷新, 并实现动画.
//     */
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}
//#pragma mark 调用该方法, 可更改按钮显示的文字.
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}
#pragma mark 调用该方法, 可为向左滑动增加新按钮与想要实现的功能
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    //创建两个UITableViewRowAction对象, 并设置其样式及标题, 在下面的block中实现相应的操作
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"关注按钮被点击");
        tableView.editing = NO;
    }];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        //通过修改模型数据达到修改界面的目的. 删除所选择的那一行.
        [self.wineArray removeObjectAtIndex:indexPath.row];
    
        /**在数组中删除模型后, 需对tableView进行刷新,
         这里使用deleteRowsAtIndexPaths:进行局部刷新, 并实现动画.
         */
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            tableView.editing = NO;
    }];
    return @[action2, action1];
}
#pragma mark 在选中某行后,在该方法中实现对状态(wine.isSelected)的修改
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YHWine *wine = self.wineArray[indexPath.row];



    //判断勾选状态.
    if (wine.isSelected) {
        wine.selected = NO;
        [self.selectedIndexPath removeObject:indexPath];
    }
    else{
        wine.selected = YES;
        [self.selectedIndexPath addObject:indexPath];

    }

    //refresh按钮的显示与否
    if (self.selectedIndexPath.count == 0) {
        self.refresh.enabled = NO;
    }
    else
        self.refresh.enabled = YES;

    //更改模型后, 刷新相应行的状态
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}


@end
