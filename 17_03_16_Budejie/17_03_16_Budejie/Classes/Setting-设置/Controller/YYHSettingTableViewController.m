//
//  YYHSettingTableViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHSettingTableViewController.h"
#import "YYHFileTools.h"
#import <SVProgressHUD.h>
#define cacheFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

static NSString  *const ID = @"cell";

@interface YYHSettingTableViewController ()

/** <#comments#>*/
@property (nonatomic, assign) NSInteger totalSize;
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


    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];

    [SVProgressHUD showWithStatus:@"正在计算缓存..."];
    [YYHFileTools fileSizeForDirectory:cacheFilePath completion:^(NSInteger totalSize) {
        self.totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];


    }];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];


    cell.textLabel.text = [self getCacheSize];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //点击清除缓存
//    [self clearCache];
//    [YYHFileTools removeItemAtDirectoryPath:cacheFilePath];
    //清除完成后需要刷新, 获取最新数据
    [self.tableView reloadData];
}


/**
获取文件大小的字符串

 */
- (NSString *)getCacheSize{

    //1. 找到存放缓存的文件夹
//    NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    //2. 使用文件管理者
//    NSFileManager *fileManger = [NSFileManager defaultManager];
//    //拿到缓存文件夹下, 所有子文件的路径
//    NSArray *subPathArray = [fileManger subpathsAtPath:cacheFilePath];
//
//    float totalSize = 0;
//
//    NSString *totalSizeStr = @"清除缓存";
//    for (NSString *filePath in subPathArray) {
//            //拼接路径
//        NSString *fileFullPath = [cacheFilePath stringByAppendingPathComponent:filePath];
//
//        //通过文件管理者拿到对应文件的属性
//        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:fileFullPath error:nil];
//        //通过@"NSFileSize"拿到每一个文件的大小.
//        totalSize =totalSize + [fileDict[@"NSFileSize"] floatValue];
//
//    }
    NSInteger totalSize = self.totalSize;
    
    NSString *totalSizeStr = @"清除缓存";
    if (totalSize > 1000 * 1000) {
        totalSizeStr = [NSString stringWithFormat:@"%@(%.2fMB)",totalSizeStr, totalSize / 1000.0 / 1000.0];
    }
    else if (totalSize > 1000)
    {
        totalSizeStr = [NSString stringWithFormat:@"%@(%.2fMB)",totalSizeStr, totalSize / 1000.0 ];
    }
    else if (totalSize > 0)
    {
        totalSizeStr = [NSString stringWithFormat:@"%@(%.2ldMB)",totalSizeStr, (long)totalSize];
    }

    return totalSizeStr;



    //3. 得到缓存文件的大小
    //4. 遍历计算大小
    //5. 返回计算值
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
