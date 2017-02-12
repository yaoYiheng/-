//
//  ViewController.m
//  17_02_12_复杂JSON解析
//
//  Created by 姚懿恒 on 2017/2/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
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
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //拿到数据后将data转为对象


        //容错处理
        if(connectionError) return ;

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

        self.dataArray = dict[@"videos"];

        NSLog(@"%@", dict);
//        [self.tableView reloadData];

        //刷新tableView, 回到主线程中
        [self.tableView performSelector:@selector(reloadData) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }];
}


@end
