//
//  ViewController.m
//  17_03_10_block相关
//
//  Created by 姚懿恒 on 2017/3/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "CellItem.h"


/**
 使用typedef定义了一个ReturnString类型的 block
 */
typedef NSString *(^ReturnString)(NSString * , NSString *);

@interface ViewController ()
/** 声明了一个变量名为myblock的block, 该block的类型是接收两个int 参数, 返回值也为int的block*/
@property (nonatomic, strong) int(^myblock)(int, int);

/** 自定义block*/
@property (nonatomic, strong) ReturnString returnBlock;

/** items数组*/
@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CellItem *item1 = [CellItem itemWithString:@"打电话"];
    CellItem *item2 = [CellItem itemWithString:@"发短信"];
    CellItem *item3 = [CellItem itemWithString:@"发邮件"];

    self.items = @[item1, item2, item3];


    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    CellItem *item = self.items[indexPath.row];
    cell.textLabel.text = item.mission;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _items.count;
}



- (void)block1{
    //block的声明与定义: 返回值类型(^block变量名)(参数1, 参数2,...)
    NSString *(^returnString)(NSString * , NSString *) = ^(NSString *str1, NSString *str2){
        NSMutableString *newStr = [NSMutableString string];

        [newStr appendString:str1];
        [newStr appendFormat:@"123%@", str2];

        return newStr;
    };

    //block的声明
    NSString *(^returnString1)(NSString * , NSString *);

    //通过typedef, 定义了一个需要传入两个string对象作为参数, 返回值为string, 类型为ReturnString, 变量名为returnBlock 的block
    self.returnBlock = ^(NSString *str1, NSString *str2){
        NSMutableString *newStr = [NSMutableString string];

        [newStr appendString:str1];
        [newStr appendFormat:@"123%@", str2];

        return newStr;
    };

    // block快捷方式 inline
    //    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
    //        <#statements#>
    //    };

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"%@", self.returnBlock(@"zhangmm", @"chibaba"));

}


@end
