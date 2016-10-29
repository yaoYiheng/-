//
//  ViewController.m
//  16_10_29_UITableView练习
//
//  Created by 姚懿恒 on 2016/10/29.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHGroupOfCars.h"
#import "YHCar.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 数组数据*/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        //从NSBundle中加载plist文件到数组.
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars.plist" ofType:nil];
        NSArray *carsArray = [NSArray arrayWithContentsOfFile:path];

        //将数组文件转化为模型, 并添加到dataArray中
        NSMutableArray *tmp = [NSMutableArray array];
        for (NSDictionary *carGroup in carsArray) {
            YHGroupOfCars *cars = [YHGroupOfCars groupOfCarsWithDictionary:carGroup];
            [tmp addObject:cars];
        }

        _dataArray = tmp;
    }

    return _dataArray;
    
}

/**
 告诉控制器一共有多少组数据

 @return 模型数组中有多少元素即返回多少组需要显示的内容
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

/**
 告诉控制器每一组元素中需要显示多少行数据


 @return 拿到对应组的模型, 返回模型中cars成员变量(数组)的个数.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YHGroupOfCars *cars = _dataArray[section];
    return cars.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //绑定一个标识, 重新利用cell
    static NSString *ID = @"XI";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    //拿到传入的某组的carsInGroup, 
    YHGroupOfCars *carsInGroup = self.dataArray[indexPath.section];
    YHCar *cars = carsInGroup.cars[indexPath.row];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.imageView.image = [UIImage imageNamed:cars.carIcon];
    cell.textLabel.text = cars.carName;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark设置头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YHGroupOfCars *cars = self.dataArray[section];
    return [NSString stringWithFormat:@"%@", cars.header];
}
#pragma mark 设置尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    YHGroupOfCars *cars = self.dataArray[section];
    return [NSString stringWithFormat:@"%@", cars.footer];
}
#pragma mark 设置每行的宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


#pragma mark 监听cell的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"第%ld组第%ld行被点击了", (long)indexPath.section, (long)indexPath.row);
}
@end
