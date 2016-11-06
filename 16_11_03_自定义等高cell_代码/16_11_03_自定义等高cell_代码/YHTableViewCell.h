//
//  YHTableViewCell.h
//  16_11_03_自定义等高cell_代码
//
//  Created by 姚懿恒 on 2016/11/3.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHTgCell;

@interface YHTableViewCell : UITableViewCell
/** 团购cell模型*/
@property (nonatomic, strong) YHTgCell *tgCell;

@end
