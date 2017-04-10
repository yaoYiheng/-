//
//  YYHTopicPictutrView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicPictutrView.h"

@implementation YYHTopicPictutrView

+ (instancetype)yyhTopicPictutrViewFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
