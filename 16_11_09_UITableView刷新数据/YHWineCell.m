//
//  YHWineCell.m
//  16_11_09_UITableView刷新数据
//
//  Created by 姚懿恒 on 2016/11/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHWineCell.h"
#import "YHWine.h"
@implementation YHWineCell

- (void)setWine:(YHWine *)wine{
    _wine = wine;
    self.imageView.image = [UIImage imageNamed :wine.image];
    self.textLabel.text = wine.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", wine.money];
}

@end
