//
//  ViewController.m
//  17_02_12_复杂JSON解析
//
//  Created by 姚懿恒 on 2017/2/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#import "VideoItem.h"

//baseurl = @"http://120.25.226.186:32812";

#define baseurl @"http://120.25.226.186:32812"

@interface ViewController () <NSXMLParserDelegate>
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

        //创建NSXMLParser解析器
        NSXMLParser *paeser = [[NSXMLParser alloc] initWithData:data];
        //设置代理 通过代理完成解析
        paeser.delegate = self;
        //开始解析
        [paeser parse];

        NSLog(@"%@", dict);
//        [self.tableView reloadData];

        //刷新tableView, 回到主线程中
        [self.tableView performSelector:@selector(reloadData) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }];
}

#pragma mark -------
#pragma mark NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
}

#pragma mark -------
#pragma mark UITabelViewSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu ", (unsigned long)self.dataArray.count);
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"video";

    //1.从缓存中获取cell

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    NSDictionary *dict = self.dataArray[indexPath.row];
    //2. 设置cell
    cell.textLabel.text = dict[@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长%@", dict[@"length"]];
    //2.1 设置图片.
//    NSString *baseurl = @"http://120.25.226.186:32812";
    NSString *fullPath = [baseurl stringByAppendingPathComponent:dict[@"image"]];

    NSLog(@"%@", fullPath);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:fullPath] placeholderImage:[UIImage imageNamed:@"test"]];
    NSLog(@"%@", cell);
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dict = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *urlStr = [baseurl stringByAppendingPathComponent:dict[@"url"]];
    //3.创建播放控制器


    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStr]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
