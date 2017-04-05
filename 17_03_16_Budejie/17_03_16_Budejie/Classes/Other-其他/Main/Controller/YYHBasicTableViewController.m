//
//  YYHBasicTableViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/31.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
    为tableView添加footerView, 提示用户上拉加载更多数据.
 */

#import "YYHBasicTableViewController.h"
#import <AFNetworking.h>
#import "NSDictionary+Property.h"
#import <MJExtension.h>
#import "YYHTopicsItem.h"
#import <SVProgressHUD.h>

@interface YYHBasicTableViewController ()
/** 刷新label*/
@property (nonatomic, weak) UILabel *footerRefreshLabel;
/** 刷新label*/
@property (nonatomic, weak) UILabel *headerRefreshLabel;
/** 是否正在刷新*/
@property (nonatomic, assign, getter=isfooterRefreshing) BOOL footerRefreshing;

/** 是否正在刷新, 该属性的作用是控制刷新控件多次刷新.*/
@property (nonatomic, assign, getter=isheaderRefreshing) BOOL headerRefreshing;
/** <#comments#>*/
@property (nonatomic, assign) NSInteger dataCount;
/** footerView*/
@property (nonatomic, weak) UIView *footerView;

/** footerView*/
@property (nonatomic, weak) UIView *headerView;
/** 帖子数组*/
@property (nonatomic, strong) NSMutableArray *topcisArray;
@end

@implementation YYHBasicTableViewController

#pragma mark - ----view周期方法-----
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YYHRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(YYHTitleViewHeight + YYHNaviBarMaxY, 0, YYHTabBarHeight, 0);
    //修改指示器的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    //监听按钮多次点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDoubleClick) name:YYHTabBarButtonDidDoubleClickNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:YYHTitleButtonDidDoubleClickNotification object:nil];


    [self configureHeaderView];
    //添加footerView
    [self configureFooterView];
//    self.dataCount = 5;


}

-(void)dealloc{
    //从通知中心中移除观察者
    YYHFunc
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ----初始化控件-----
- (void)configureFooterView{
    UIView *footerView = [[UIView alloc] init];

    footerView.frame = CGRectMake(0, 0, YYhScreenW, 44);
    footerView.backgroundColor = YYHRandomColor;
    UILabel *label = [[UILabel alloc] init];
    label.frame = footerView.bounds;
    label.textColor = YYHRandomColor;
    label.text = @"上拉加载更多...";
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    
    self.footerRefreshLabel = label;
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
}
- (void)configureHeaderView{
    UIView *headerView = [[UIView alloc] init];

    headerView.frame = CGRectMake(0, -YYHHeaderViewHeight, YYhScreenW, YYHHeaderViewHeight);
    headerView.backgroundColor = YYHRandomColor;
    UILabel *label = [[UILabel alloc] init];
    label.frame = headerView.bounds;
    label.textColor = YYHRandomColor;
    label.text = @"下拉加载更多...";
    label.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label];

    self.headerRefreshLabel = label;
    [self.tableView addSubview:headerView];
    self.headerView = headerView;
    [self headerStartRefresh];
}
#pragma mark - ----上拉, 下拉-----

/**
 上拉刷新
 */
- (void)draggingUp{

    //view刚加载时,tableView.contentSize为0.不需要刷新.
    if (self.tableView.contentSize.height == 0) return;

    //计算footerView完全出现时的偏移量
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.yyh_height - YYHFooterViewHeight;

    //当数据量比较少时,如果footerView也能够被看到的情况, 一般会下拉刷新最新数据, 这里上拉加载更多也会相应下拉动作, 所以这里需要加一个判断, 只有上拉时, 才需要刷新
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top)) {

        [self footerStartRefresh];
    }

}

/**
 下拉刷新
 */
- (void)draggingDown{

    if(self.headerRefreshing) return;
    //当下拉偏移量
    CGFloat headerOffsetY = -(self.tableView.contentInset.top + YYHHeaderViewHeight);

    if (self.tableView.contentOffset.y <= headerOffsetY) {
        self.headerRefreshLabel.text = @"松开立即刷新...";
    }
    else{
        self.headerRefreshLabel.text = @"下拉加载更多...";

    }

}
#pragma mark - ----监听scrollView的滚动-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理下拉刷新业务
    [self draggingDown];

    //处理上拉刷新业务
    [self draggingUp];


}

/**
 手指离开屏幕时调用

 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //当下拉偏移量
    CGFloat headerOffsetY = -(self.tableView.contentInset.top + YYHHeaderViewHeight);

    //当headerRefreshLabel完全显示时, 表示需要刷新数据
    if (self.tableView.contentOffset.y <= headerOffsetY) {

        [self headerStartRefresh];
    }

}
#pragma mark - -------获取数据--------------

/**
 下拉获取新数据
 */
//- (void)getNewData{
//    //模拟2秒后服务器返回数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.dataCount = 20;
//        [self.tableView reloadData];
//
//        //当返回数据后, 更改相关状态
//
//        [self headerFinishRefresh];
//    });
//
//}

/**
 请求最新数据
 
 查看API, 获取相关有用信息
 url: http://api.budejie.com/api/api_open.php
 发送get请求, 
 参数:
    a 参数值为list，如果想要获取“新帖”板块的帖子，则传入"newlist"即可
    c data
    type 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
 maxtime 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。

 */
- (void)getNewData{
    //1创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";

    //3.发现发送所有请求的url都是一样的, 所以将其抽成宏

    [manager GET:YYHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //为了方便查看, 将该字典写成plist文件.
        //        [NSString stringWithFormat:@"/Users/xiaomage/Desktop/%@.plist", @#filename];
//#define YYHAFNWriteToPlist(fileName) [NSString stringWithFormat:@"/Users/Morris/Desktop/%@.plist",fileName];
//        [responseObject writeToFile:@"/Users/Morris/Desktop/topics.plist" atomically:YES];

//        YYHAFNWriteToPlist(@"new_topics")

        //已经能够成功获取服务器返回数据 -> 将字典数组转化成模型数组 -> 创建模型 ->MJ框架

        //所需要的字典数组存放在responseObject[@"list"]中
        self.topcisArray = [YYHTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //拿到数据后需要刷新
        [self.tableView reloadData];

        [self headerFinishRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        //弹出提示框
        [SVProgressHUD showErrorWithStatus:@"网络不给力, 请稍后再试!"];
        //无论返回失败或是成功, 都需要结束刷新.
        [self headerFinishRefresh];
    }];

//    self.dataCount = 20;
//    [self.tableView reloadData];

    //当返回数据后, 更改相关状态



}
/**
 上拉获取更多数据
 */
//- (void)getMoreData{
//    //模拟向服务器请求输入
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 服务器请求回来了
//        self.dataCount += 5;
//        [self.tableView reloadData];
//
//        // 结束刷新
//
//        [self footerFinishRefresh];
//    });
//
//
//}
- (void)getMoreData{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";


    [manager GET:YYHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {

        //将更多数据拼到已有的数据之后
        //从返回的数据中拿到字典数组
        NSArray *array = responseObject[@"list"];

        //
        NSArray *moreTopcis = [YYHTopicsItem mj_objectArrayWithKeyValuesArray:array];

        //不是调用addObject:
//        [[self.topcisArray addObject:moreTopcis] ]
        [self.topcisArray addObjectsFromArray:moreTopcis];

        //刷新
        [self.tableView reloadData];


        //结束footer的刷新
        [self footerFinishRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"网络不给力, 请稍后再试!"];
        //结束footer的刷新
        [self footerFinishRefresh];


    }];
    
    
}
#pragma mark - header开始刷新, 结束刷新
- (void)headerStartRefresh{

    //如果正在刷新就返回
    if(self.headerRefreshing) return;

    self.headerRefreshLabel.text = @"正在刷新..";

    //使用一个属性来记录当前的刷新状态, 如果已经是刷新状态, 就不需要将下拉刷新时的标题改为...
    self.headerRefreshing = YES;
    //修改tableView内边距, 使headerRefreshLabel停留值数据返回
    [UIView animateWithDuration:0.4 animations:^{

        UIEdgeInsets topInsets = self.tableView.contentInset;
        topInsets.top += YYHHeaderViewHeight;
        self.tableView.contentInset = topInsets;

        //当下拉刷新时,特别是通过点击tabBarButton或titleButton时的刷新, 需要修改tableView的内容偏移量为能够使headerRefreshLabel显示的值, 
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -(self.tableView.contentInset.top));

    }];

    //获取最新数据
    [self getNewData];



}
- (void)headerFinishRefresh{
    //
    self.headerRefreshing = NO;
    UIEdgeInsets topInsets = self.tableView.contentInset;
    topInsets.top -= YYHHeaderViewHeight;
    self.tableView.contentInset = topInsets;

}
#pragma mark - footer开始刷新, 结束刷新
- (void)footerStartRefresh{
    //如果已经在刷新了就返回
    if(self.footerRefreshing) return;




    NSLog(@"刷新数据");
    self.footerRefreshing = YES;
    //更改Label文字
    self.footerRefreshLabel.text = @"正在加载更多...";

    [self getMoreData];

}
- (void)footerFinishRefresh{
    //            [view stopAnimating];
    self.footerRefreshing = NO;
    self.footerRefreshLabel.text = @"上拉加载更多";
//    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.yyh_height - YYHFooterViewHeight);
//    [UIView animateWithDuration:0.6 animations:^{
//        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.yyh_height - YYHFooterViewHeight);
//    }];

}
#pragma mark - ----监听按钮点击-----
- (void)tabBarButtonDoubleClick{

    if (self.view.window == nil) return;

    if (self.tableView.scrollsToTop == NO) return;

    [self headerStartRefresh];
    NSLog(@"%@刷新数据%s", self.class, __func__);

}
/**
 *  监听titleButton重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDoubleClick];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.footerView.hidden = self.topcisArray.count == 0;
    return self.topcisArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    YYHTopicsItem *topic = self.topcisArray[indexPath.row];

    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;


    return cell;
}
@end
