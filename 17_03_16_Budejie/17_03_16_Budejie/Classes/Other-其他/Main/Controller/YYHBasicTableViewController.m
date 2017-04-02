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
@property (nonatomic, weak) UILabel *refreshLabel;
/** 是否正在刷新*/
@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;
/** <#comments#>*/
@property (nonatomic, assign) NSInteger dataCount;
/** footerView*/
@property (nonatomic, weak) UIView *footerView;
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
    self.dataCount = 0;

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
    
    self.refreshLabel = label;
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
}
#pragma mark -----监听scrollView的滚动-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f", scrollView.contentOffset.y);
    //如果已经在刷新了就返回
    if(self.refreshing) return;

    //view刚加载时,tableView.contentSize为0.不需要刷新.
    if (self.tableView.contentSize.height == 0) return;
    //计算footerView完全出现时的偏移量
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.yyh_height - self.refreshLabel.yyh_height;

    if (scrollView.contentOffset.y >= offsetY) {
        NSLog(@"刷新数据");
        self.refreshing = YES;
        //更改Label文字
        self.refreshLabel.text = @"正在加载更多...";

        //加入UIActivityIndicatorView
//        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] init];
//        [view startAnimating];
//        [self.tableView.tableFooterView addSubview:view];
//        view.yyh_centerX = self.tableView.tableFooterView.yyh_centerX;

        //模拟向服务器请求输入
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 服务器请求回来了
            self.dataCount += 15;
            [self.tableView reloadData];

            // 结束刷新
//            [view stopAnimating];
            self.refreshing = NO;
            self.refreshLabel.text = @"上拉加载更多";
//            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, offsetY);

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
