//
//  YYHSettingCellTableViewCell.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYHCellItem, YYHItemInCellArray;

@interface YYHSettingCellTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** cellitem*/
@property (nonatomic, strong)  NSDictionary *cellItem;
@end
