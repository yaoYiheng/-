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

@interface ViewController ()<UITableViewDataSource, UITableViewDataSource>

/** 酒模型数组*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (nonatomic, strong) NSMutableArray *wineArray;
@end

@implementation ViewController

- (NSMutableArray *)wineArray{
    if (!_wineArray) {
        _wineArray = [YHWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}
    NSString *ID = @"wine";
- (void)viewDidLoad {
    [super viewDidLoad];

    //调用该属性允许在进入编辑模式时选择多行
    self.tableView.allowsMultipleSelectionDuringEditing = YES;

    self.deleteButton.enabled = NO;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wineArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHWineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YHWineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.wine = self.wineArray[indexPath.row];
    return cell;;
}
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


@end
