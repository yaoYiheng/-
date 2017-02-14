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
#import "MJExtension.h"
#import <AVFoundation/AVFoundation.h>
#import "GDataXMLNode.h"
#import "VideoItem.h"

//baseurl = @"http://120.25.226.186:32812";

#define baseurl @"http://120.25.226.186:32812"

@interface ViewController () <NSXMLParserDelegate>
/** <#comments#>*/
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)test{

}
- (void)viewDidLoad {
    [super viewDidLoad];

    //替换
        [VideoItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ID":@"id"
                     };
        }];
    //从网络获JSON数据
    //1. 确定URL
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=XML"];
    //2. 创建请求体
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3. 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //拿到数据后将data转为对象
//
//
//        //容错处理
//        if(connectionError) return ;
//
//        //创建NSXMLParser解析器
//        NSXMLParser *paeser = [[NSXMLParser alloc] initWithData:data];
//        //设置代理 通过代理完成解析
//        paeser.delegate = self;
//        //开始解析
//        [paeser parse];


        //加载XML文档.
        GDataXMLDocument *docu = [[GDataXMLDocument alloc] initWithData:data options:kNilOptions error:nil];

        //拿到根元素, 得带所有名为video的子元素
        NSArray *array = [docu.rootElement elementsForName:@"video"];

        //变量所有子元素, 子元素的类型为GDataXMLElement
        for (GDataXMLElement *element in array) {
            VideoItem *item = [[VideoItem alloc] init];

            //调用attributeForName为相关属性赋值,
            item.name = [element attributeForName:@"name"].stringValue;
            item.length = [element attributeForName:@"length"].stringValue;
            item.url = [element attributeForName:@"url"].stringValue;
            item.image = [element attributeForName:@"image"].stringValue;
            item.ID = [element attributeForName:@"id"].stringValue;

            [self.dataArray addObject:item];
        }




        //刷新tableView, 回到主线程中
//        [self.tableView performSelector:@selector(reloadData) onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];

        [self.tableView reloadData];

    }];
}

#pragma mark -------
#pragma mark NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    //开始逐一解析XML文件, 每解析一次便会来到该方法, 所以在该方法中, 使用MJ框架,将字典转化为模型数组
    //过滤根元素
    if ([elementName isEqualToString:@"videos"]) {
        return;
    }
    [self.dataArray addObject:[VideoItem mj_objectWithKeyValues:attributeDict]];
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


    VideoItem *item = self.dataArray[indexPath.row];
    //2. 设置cell
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长%@", item.length];
    //2.1 设置图片.
//    NSString *baseurl = @"http://120.25.226.186:32812";
    NSString *fullPath = [baseurl stringByAppendingPathComponent:item.image];

    NSLog(@"%@", fullPath);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:fullPath] placeholderImage:[UIImage imageNamed:@"test"]];
    NSLog(@"%@", cell);
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    NSDictionary *dict = self.dataArray[indexPath.row];
    VideoItem *item = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *urlStr = [baseurl stringByAppendingPathComponent:item.url];
    //3.创建播放控制器


    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStr]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
