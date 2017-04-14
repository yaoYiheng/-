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

    _cellHeight += YYHMargin;
    //计算对应控件的高度, 只有当类型不为段子时, 才需要计算中间控件的高度
    if (self.type != YYHTopicTypeWord) {
        //计算控件高度
        CGFloat middleW = textMaxSize.width;
        CGFloat middleX = YYHMargin;
        CGFloat middleY = _cellHeight;
        CGFloat middleH = middleW * self.height / self.width;
        if (middleH > YYHScreenH) {
            middleH = 200;
            self.bigPicure = YES;
        }


        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += YYHMargin + middleH;
    }

    //最热评论高度
    if (self.top_cmt.count) {
        //标题高度
        _cellHeight += 21;

        //内容高度
        NSDictionary *topComment = self.top_cmt.firstObject;
        NSString *content = topComment[@"content"];
        //判断如果内容为0, 则语音信息
        if(content.length == 0){
            content = @"[语音评论]";
        }
        NSString *userName = topComment[@"user"][@"username"];
        NSString *contentText = [NSString stringWithFormat:@"%@ : %@", userName, content];
        _cellHeight += [contentText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + YYHMargin;
    }

    // 工具条
    _cellHeight += 35 + YYHMargin;

    return _cellHeight;
}
@end
