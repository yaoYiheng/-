//
//  ViewController.m
//  16_11_05_自定义不等高cell
//
//  Created by 姚懿恒 on 2016/11/5.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHStatus.h"
#import "YHStatuesCell.h"
#import "MJExtension.h"

@interface ViewController ()
/** 微博数据数组*/
@property (nonatomic, strong) NSArray *statusData;

@end

@implementation ViewController

NSString *ID = @"weibo";

- (NSArray *)statusData{
    if (!_statusData) {
        _statusData = [YHStatus mj_objectArrayWithFilename:@"statuses.plist"];
    }
    return _statusData;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[YHStatuesCell class] forCellReuseIdentifier:ID];
    NSLog(@"%@", _statusData);
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.statusData.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YHStatuesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    cell.statuses = self.statusData[indexPath.row];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //声明高度初始化为0
    CGFloat cellHeight = 0;

    //拿到对应行的Status
    YHStatus *statuses = self.statusData[indexPath.row];

    /** 重新计算影响cell高度的子控件并返回新高度.*/
    CGFloat space = 10;

    /**头像图片 */
    CGFloat iconX = space;
    CGFloat iconY = space;
    CGFloat iconWH = 30;
    CGRect iconImageViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);



    /**微博内容 */
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(iconImageViewFrame) + space;
    CGFloat contentW = self.view.frame.size.width - 2 *space;

    NSDictionary *contentAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);


    CGFloat contentH = [statuses.text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttribute context:nil].size.height;

    CGRect contentLabelFrame = CGRectMake(contentX, contentY, contentW, contentH);


    /**微博图片 */
    if (statuses.picture) {
        CGFloat pictureX = space;
        CGFloat pictureY = CGRectGetMaxY(contentLabelFrame) + space;
        CGFloat pictureWH = 150;
        CGRect pictureImageViewFrame = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);

        //如果有图片, cell的高度为图片最大Y值+间距
        cellHeight = CGRectGetMaxY(pictureImageViewFrame) + space;
    }else
    {   //没有图片, 正文内容加上间距
        cellHeight = CGRectGetMaxY(contentLabelFrame) + space;
    }


    return cellHeight;
}

@end
