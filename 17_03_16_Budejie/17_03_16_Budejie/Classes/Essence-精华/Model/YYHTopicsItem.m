//
//  YYHTopicsItem.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/5.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicsItem.h"

@implementation YYHTopicsItem

- (CGFloat )cellHeight{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    //根据模型的数据计算每行的高度


    // 文字的Y值
    _cellHeight += 55;

    // 文字的高度
    CGSize textMaxSize = CGSizeMake(YYhScreenW - 2 * YYHMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + YYHMargin;


    // 工具条
    _cellHeight += 35 + YYHMargin * 2;

    return _cellHeight;
}
@end
