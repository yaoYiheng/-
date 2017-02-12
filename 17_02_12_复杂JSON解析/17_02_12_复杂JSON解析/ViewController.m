//
//  ViewController.m
//  17_02_12_复杂JSON解析
//
//  Created by 姚懿恒 on 2017/2/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** <#comments#>*/
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //从网络获JSON数据
    //1. 确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=JSON"];
    //2. 创建请求体
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3. 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //拿到数据后将data转为对象


        //容错处理
        if(connectionError) return ;

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        self.dataArray = dict[@"video"];

        //刷新tableView, 回到主线程中
        [self performSelector:@selector(reloadData) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }];
}

#pragma mark -------
#pragma mark UITabelViewSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"vedio";

    //1.从缓存中获取cell

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    NSDictionary *dict = self.dataArray[indexPath.row];
    //2. 设置cell
    cell.textLabel.text = dict[@"name"];
    cell.detailTextLabel.text = dict[@"length"];
    //2.1 设置图片.

}


@end
