//
//  YYHSettingTableViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHSettingTableViewController.h"
#import "YYHCellItem.h"
#import "YYHItemInCellArray.h"
#import "MJExtension.h"

@interface YYHSettingTableViewController ()

/** 数组数据*/
@property (nonatomic, strong) NSArray *cellDataArray;

@end

@implementation YYHSettingTableViewController

- (NSArray *)cellDataArray{
    if (!_cellDataArray) {
//        _cellDataArray = [YYHCellItem mj_objectArrayWithFile:@"cars.plist"];

        NSMutableArray *temp = [NSMutableArray array];


        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];

        for (NSDictionary *items in array) {

            YYHCellItem *cellItem = [YYHCellItem cellItemWithDict:items];
            [temp addObject:cellItem];
        }
        _cellDataArray = temp;
        //从plist文件中加载数据调用该方法 mj_objectArrayWithFilename, 与以上方法进行区分.
//        _cellDataArray = [YYHCellItem mj_objectArrayWithFilename:@"cars.plist"];
    }
    return _cellDataArray;

}

/**
 重写init方法, 外界调用时, 直接返回grouped样式的cell
 */
- (instancetype)init{

    return [self initWithStyle:UITableViewStyleGrouped];
}
static NSString * const reuseID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];


    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];

    NSLog(@"%@", self.cellDataArray);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    YYHCellItem *items = self.cellDataArray[section];

    return items.arrayForCell.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }

    YYHCellItem *item = self.cellDataArray[indexPath.section];
    NSLog(@"%@", item.footer);
    YYHItemInCellArray *itemInArray = item.arrayForCell[indexPath.row];
    NSLog(@"%@", itemInArray.icon);
    NSLog(@"%@", itemInArray.name);

    NSLog(@"====");
    
    cell.textLabel.text = itemInArray.name;
    cell.imageView.image = [UIImage imageNamed:itemInArray.icon];


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
