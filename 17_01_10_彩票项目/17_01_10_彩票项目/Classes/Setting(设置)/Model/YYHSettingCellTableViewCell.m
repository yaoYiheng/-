//
//  YYHSettingCellTableViewCell.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHSettingCellTableViewCell.h"
#import "YYHCellItem.h"
#import "YYHItemInCellArray.h"

@implementation YYHSettingCellTableViewCell
static NSString * const reuseID = @"cell";
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";

    YYHSettingCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[YYHSettingCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setCellItem:(NSDictionary *)cellItem{

    _cellItem = cellItem;
    self.imageView.image = [UIImage imageNamed:cellItem[@"icon"]];
    self.textLabel.text = cellItem[@"name"];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
