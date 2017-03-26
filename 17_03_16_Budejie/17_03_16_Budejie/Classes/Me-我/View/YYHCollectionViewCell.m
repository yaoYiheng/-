//
//  YYHCollectionViewCell.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/26.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHCollectionViewCell.h"
#import "YYHCellItem.h"
#import <UIImageView+WebCache.h>
@interface YYHCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *topicLabel;

@end

@implementation YYHCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(YYHCellItem *)item{
    _item = item;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.topicLabel.text = item.name;
//    [self.topicLabel sizeToFit];
}

@end
