//
//  YYHReuseCollectionViewCell.m
//  17_04_25_CollectionView循环利用tableView
//
//  Created by 姚懿恒 on 2017/4/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHReuseCollectionViewCell.h"

@interface YYHReuseCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** <#comments#>*/
@property (nonatomic, assign) CGPoint currentOffset;

@end
@implementation YYHReuseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)setItem:(NSString *)item{
    _item = [item copy];

//    _item = item;
    //刷新数据更新tableView
    [self.tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%ld",self.item, indexPath.row];

    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

@end
