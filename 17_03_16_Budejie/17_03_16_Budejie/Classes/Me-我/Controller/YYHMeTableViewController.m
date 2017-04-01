//
//  YYHMeTableViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
/*
    搭建 我的 界面
 由静态cell + UICollectionView组成 -> 通过storyboard取描述该页面 -> 在tabBarVC中设置该页面从storyboard中加载 -> 调整 cell间距以及tableView的内边距 -> 添加collectionView作为cell的footerView -> 设置并展示cell.
 */

#import "YYHMeTableViewController.h"
#import "YYHSettingTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "YYHCellItem.h"
#import <MJExtension/MJExtension.h>
#import "YYHCollectionViewCell.h"
#import <SafariServices/SafariServices.h>
#import "YYHWebViewController.h"

static NSString * const reusrID = @"cell";
static CGFloat const margin = 1;
static int const column = 4;
#define itemWH (YYhScreenW - margin * (column - 1)) / column

@interface YYHMeTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

/** 模型数组*/
@property (nonatomic, strong) NSMutableArray *itemsArray;
/** <#comments#>*/
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation YYHMeTableViewController

#pragma mark -----懒加载-----

- (NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *nightButton = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] Target:self action:@selector(nightModel:)];

    UIBarButtonItem *settingButton = [UIBarButtonItem barButtonWithImage:[UIImage imageNamed:@"mine-setting-icon"] hightligtedImage:[UIImage imageNamed:@"mine-setting-icon-click"] Target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems = @[settingButton, nightButton];

    self.navigationItem.title = @"我的";

    //设置,处理cell间距,默认tableView分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;

    self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);

    //UICollectionView可以作为cell的footView添加到界面上
    [self configureFooterView];

    //请求数据
    [self loadData];


//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSLog(@"%@", path);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDoubleClick) name:YYHTabBarButtonDoubleClickNotification object:nil];

}

-(void)dealloc{
    //从通知中心中移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tabBarButtonDoubleClick{

    if (self.view.window == nil) return;

    if (self.tableView.scrollsToTop == NO) return;

    NSLog(@"%@", self.class);
    
}

-(void)loadData{
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //拼接参数a: square c:topic
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    //发送请求
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {

        NSMutableArray *dictInarray = responseObject[@"square_list"];


        //将字典数组转换成为模型数组 ->创建模型.
        self.itemsArray = [YYHCellItem mj_objectArrayWithKeyValuesArray:dictInarray];

//        NSLog(@"%@", self.itemsArray);
        //补充剩下的空白
        [self addPlaceHolder];

        //当刷新完数据后, 需要重新设置collectionView的高度 rows * itemWH
        NSInteger rows = (self.itemsArray.count - 1) / column + 1;
        self.collectionView.yyh_height = rows * itemWH;
        self.tableView.tableFooterView = self.collectionView;

        //刷新数据
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}
- (void)addPlaceHolder{
    //计算需要添加的个数

    NSInteger extra = self.itemsArray.count % column;


    if (extra) {
        NSInteger count = column - extra;
        for (int i = 0; i < count; i++) {
            YYHCellItem *item = [[YYHCellItem alloc] init];
            [self.itemsArray addObject:item];

        }
    }

}
- (void)configureFooterView{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 700) collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"YYHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reusrID];
    self.tableView.tableFooterView = collectionView;
}

#pragma mark -----UICollectionViewDelegate-----

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 跳转界面 push 展示网页
    /*
     1.Safari openURL :自带很多功能(进度条,刷新,前进,倒退等等功能),必须要跳出当前应用
     2.UIWebView (没有功能) ,在当前应用打开网页,并且有safari,自己实现,UIWebView不能实现进度条
     3.SFSafariViewController:专门用来展示网页 需求:即想要在当前应用展示网页,又想要safari功能 iOS9才能使用
     3.1 导入#import <SafariServices/SafariServices.h>

     4.WKWebView:iOS8 (UIWebView升级版本,添加功能 1.监听进度 2.缓存)
     4.1 导入#import <WebKit/WebKit.h>

     */


    YYHCellItem *item = self.itemsArray[indexPath.row];

    YYHWebViewController *webVC = [[YYHWebViewController alloc] init];
    webVC.url = [NSURL URLWithString:item.url];

    [self.navigationController pushViewController:webVC animated:YES];

//    if ([item.url containsString:@"http"]) {
//        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString: item.url]];
//
////        [self.navigationController pushViewController:safariVC animated:YES];
//        [self presentViewController:safariVC animated:YES completion:nil];
//    }

}

#pragma mark - SFSafariViewControllerDelegate

/**
 代理方法, 实现该方法,点击Done时, 调回之前页面
 */
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark -----UICollectionViewDataSource-----

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    YYHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusrID forIndexPath:indexPath];
    YYHCellItem *item = self.itemsArray[indexPath.row];
    cell.item = item;

    return cell;
}
- (void)nightModel:(UIButton *)button{

    button.selected =!button.isSelected;
}

/**
 点击后跳转到setting的控制器
 */
- (void)setting{

    YYHSettingTableViewController *settingVC = [[YYHSettingTableViewController alloc] init];
    //只有在跳转之前设置该属性, 才能在跳转后实现隐藏底部tabBar的效果.
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
