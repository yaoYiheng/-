//
//  ViewController.m
//  16_11_02_索引条
//
//  Created by 姚懿恒 on 2016/11/2.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHCarsInGroup.h"
#import "YHCarGroups.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 数据源数组*/
@property (nonatomic, strong) NSArray *allData;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置索引条的文字颜色
    self.tableView.sectionIndexColor = [UIColor redColor];

    //设置索引条的背景颜色
    self.tableView.sectionIndexBackgroundColor = [UIColor yellowColor];

}
#pragma mark 懒加载数据源数组
- (NSArray *)allData{
    if (!_allData) {
        //从mainBundle中加载数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars" ofType:@"plist"];
        NSArray *dataFromBundle = [NSArray arrayWithContentsOfFile:path];

        //遍历dataFromBundle, 传入字典, 将字典转化为模型, 加入到_allData中
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *carGroupsInDict in dataFromBundle) {
            YHCarGroups *carGroup = [YHCarGroups carGroupWithDictionary:carGroupsInDict];
            [temp addObject:carGroup];
        }
        _allData = temp;

    }
    return _allData;
}

#pragma mark 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allData.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YHCarGroups *carsInGroup = _allData[section];
    return carsInGroup.carArrays.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //1.绑定标识
    static NSString *ID = @"cars";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    //拿到对应行号的组
    YHCarGroups *carGroups = self.allData[indexPath.section];
    YHCarsInGroup *carsInGroup = carGroups.carArrays[indexPath.row];

    cell.imageView.image = [UIImage imageNamed:carsInGroup.icon];

    cell.textLabel.text = carsInGroup.carName;

    return cell;
    
}

/**
 隐藏顶部的状态栏

 */
- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark 设置头部标题.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YHCarGroups *carGroup = self.allData[section];
    return carGroup.title;
}

/**
 返回索引条字符串数组.
 该方法会返回一个字符串数组, 作为索引条.
 */
- (NSArray <NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    NSMutableArray *titleArray = [NSMutableArray array];
    for (YHCarGroups *carGroup in self.allData) {
        [titleArray addObject:carGroup.title];
    }
    return titleArray;


    return [self.allData valueForKeyPath:@"title"];

}
@end
