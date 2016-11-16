//
//  YHWineCell.h
//  16_11_15_购物车
//
//  Created by 姚懿恒 on 2016/11/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHWine, YHWineCell;

@protocol YHWineCellDelegate <NSObject>

@optional
- (void)wineCellDidClickAddButton:(YHWineCell *)wineCell;
- (void)wineCellDidClickMinusButton:(YHWineCell *)wineCell;

@end



@interface YHWineCell : UITableViewCell

/** 酒模型数据*/
@property (nonatomic, strong) YHWine *wine;
/** 代理*/
@property (nonatomic, strong) id<YHWineCellDelegate> delegate;
@end
