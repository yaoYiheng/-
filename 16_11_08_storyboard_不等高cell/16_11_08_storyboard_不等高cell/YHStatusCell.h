//
//  YHStatusCell.h
//  16_11_08_storyboard_不等高cell
//
//  Created by 姚懿恒 on 2016/11/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHStatus;

@interface YHStatusCell : UITableViewCell

/** 模型数据*/
@property (nonatomic, strong) YHStatus *status;

- (CGFloat)cellHeight;

@end
