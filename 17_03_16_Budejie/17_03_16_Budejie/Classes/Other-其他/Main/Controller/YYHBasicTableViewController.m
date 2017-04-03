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
@end

@implementation YYHBasicTableViewController

#pragma mark -----view周期方法-----
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YYHRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(YYHTitleViewHeight + YYHNaviBarMaxY, 0, YYHTabBarHeight, 0);
    //修改指示器的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

    //监听按钮多次点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDoubleClick) name:YYHTabBarButtonDidDoubleClickNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:YYHTitleButtonDidDoubleClickNotification object:nil];

    //添加footerView
    [self configureFooterView];
    self.dataCount = 5;

    [self configureHeaderView];
}

-(void)dealloc{
    //从通知中心中移除观察者
    YYHFunc
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -----初始化控件-----
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
}
#pragma mark -----上拉, 下拉-----

/**
 上拉刷新
 */
- (void)draggingUpScroll:(UIScrollView *)scrollView{
    //如果已经在刷新了就返回
    if(self.footerRefreshing) return;


    //view刚加载时,tableView.contentSize为0.不需要刷新.
    if (self.tableView.contentSize.height == 0) return;
    //计算footerView完全出现时的偏移量
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.yyh_height;

    if (self.tableView.contentOffset.y >= offsetY) {
        NSLog(@"刷新数据");
        self.footerRefreshing = YES;
        //更改Label文字
        self.footerRefreshLabel.text = @"正在加载更多...";

        //加入UIActivityIndicatorView
        //        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] init];
        //        [view startAnimating];
        //        [self.tableView.tableFooterView addSubview:view];
        //        view.yyh_centerX = self.tableView.tableFooterView.yyh_centerX;

        //模拟向服务器请求输入
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 服务器请求回来了
            self.dataCount += 5;
            [self.tableView reloadData];

            // 结束刷新
            //            [view stopAnimating];
            self.footerRefreshing = NO;
            self.footerRefreshLabel.text = @"上拉加载更多";
            //            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, offsetY);
            
        });
    }

}

/**
 下拉刷新
 */
- (void)draggingDownScroll:(UIScrollView *)scrollView{

    if(self.isheaderRefreshing) return;
    //当下拉偏移量
    CGFloat headerOffsetY = -(self.tableView.contentInset.top + YYHHeaderViewHeight);

    if (self.tableView.contentOffset.y <= headerOffsetY) {
        self.headerRefreshLabel.text = @"松开立即刷新...";
    }
    else{
        self.headerRefreshLabel.text = @"下拉加载更多...";

    }

}
#pragma mark -----监听scrollView的滚动-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理下拉刷新业务
    [self draggingDownScroll:scrollView];

    //处理上拉刷新业务
    [self draggingUpScroll:scrollView];


}

/**
 手指离开屏幕时调用

 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //当下拉偏移量
    CGFloat headerOffsetY = -(self.tableView.contentInset.top + YYHHeaderViewHeight);

    //当headerRefreshLabel完全显示时, 表示需要刷新数据
    if (self.tableView.contentOffset.y <= headerOffsetY) {
        self.headerRefreshLabel.text = @"正在刷新..";

        //使用一个属性来记录当前的刷新状态, 如果已经是刷新状态, 就不需要将下拉刷新时的标题改为...
        self.headerRefreshing = YES;
        //修改tableView内边距, 使headerRefreshLabel停留值数据返回
        [UIView animateWithDuration:0.4 animations:^{

            UIEdgeInsets topInsets = self.tableView.contentInset;
            topInsets.top += YYHHeaderViewHeight;
            self.tableView.contentInset = topInsets;

        }];
        //模拟2秒后服务器返回数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4 animations:^{

                self.dataCount = 30;
                [self.tableView reloadData];

                //当返回数据后, 更改相关状态
                //
                self.headerRefreshing = NO;
                UIEdgeInsets topInsets = self.tableView.contentInset;
                topInsets.top -= YYHHeaderViewHeight;
                self.tableView.contentInset = topInsets;
                
            }];
        });
    }

}
#pragma mark -----监听按钮点击-----
- (void)tabBarButtonDoubleClick{

    if (self.view.window == nil) return;

    if (self.tableView.scrollsToTop == NO) return;

    NSLog(@"%@刷新数据%s", self.class, __func__);

}
/**
 *  监听titleButton重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDoubleClick];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.footerView.hidden = self.dataCount == 0;
    return self.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}
@end
