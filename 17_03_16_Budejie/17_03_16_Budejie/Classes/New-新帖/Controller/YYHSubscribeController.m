//
//  YYHSubscribeController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/21.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
    发送网络请求订阅栏数据 ->查看接口文档 ->URL:http://api.budejie.com/api/api_open.php ->发送GET请求 ->必选参数 a:tags_list  c:subscribe -> 创建模型 ->自定义cell展示数据
 
 */

#import "YYHSubscribeController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "YYHTagItem.h"
#import "YYHTagCellTableViewCell.h"
#import <SVProgressHUD.h>

static NSString * const ID = @"cell";
@interface YYHSubscribeController ()
/** 模型数组*/
@property (nonatomic, strong) NSArray *itemsArray;
/** */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation YYHSubscribeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";

    //发送网络请求加载数据
    [self getData];

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YYHTagCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];

    // 设置分割线占据屏幕宽度方法一清空tableView分割线内边距 清空cell的约束边缘
//    self.tableView.separatorInset = UIEdgeInsetsZero;

    //方法二:1.清空当前分割线的样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //2. 设置当前tableView的背景颜色
    self.tableView.backgroundColor = YYHColor(220, 220, 221);

    //添加请求指示器->
    [SVProgressHUD showWithStatus:@"正在加载中.."];
}

/**
 当view即将消失时调用.
 在该方法中销毁请求指示器, 以及终止未完成的网络请求任务


 */
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [SVProgressHUD dismiss];

    //向网络会话管理者中的任务数组中的每一个元素都执行cancel方法.
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
- (void)getData{
    //1. 创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    _manager = manager;
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tags_list";
    parameters[@"c"] = @"subscribe";
    //2. 发送get请求
            //    http://api.budejie.com/api/api_open.php
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        [SVProgressHUD dismiss];
        NSArray *array = responseObject[@"rec_tags"];

        //
        self.itemsArray = [YYHTagItem mj_objectArrayWithKeyValuesArray:array];
//        NSLog(@"%@", self.itemsArray);

        //刷新数据
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    YYHTagCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
    YYHTagItem *item = self.itemsArray[indexPath.row];
    cell.tagItem = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
