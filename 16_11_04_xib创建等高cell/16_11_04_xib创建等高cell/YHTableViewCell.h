//
//  YHTableViewCell.h
//  16_11_04_xib创建等高cell
//
//  Created by 姚懿恒 on 2016/11/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHTgCell;

@interface YHTableViewCell : UITableViewCell

/** 团购模型*/
@property (nonatomic, strong) YHTgCell *tgCell;

@end
