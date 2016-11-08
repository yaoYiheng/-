//
//  YHStatusCell.m
//  16_11_08_storyboard_不等高cell
//
//  Created by 姚懿恒 on 2016/11/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHStatusCell.h"
#import "YHStatus.h"

@interface YHStatusCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureBottom;

@end
@implementation YHStatusCell
- (void)awakeFromNib{
    [super awakeFromNib];

    //手动设置文字的最大宽度,(让label能够计算出自己最真实的尺寸)
    self.text_Label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
}


- (void)setStatus:(YHStatus *)status{
    _status = status;
    self.iconImageView.image = [UIImage imageNamed:status.icon];
    self.nameLabel.text = status.name;
    self.text_Label.text = status.text;

    if (status.vip) {
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else{
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    if (status.picture) {
        self.pictureImageView.hidden = NO;
        self.pictureImageView.image = [UIImage imageNamed:status.picture];
        self.pictureH.constant = 100;
        self.pictureBottom.constant = 10;
    }
    else{
        self.pictureImageView.hidden = YES;
        self.pictureH.constant = 0;
        self.pictureBottom.constant = 0;
    }

}

- (CGFloat)cellHeight{
    // 强制刷新(label根据约束自动计算它的宽度和高度)
    [self layoutIfNeeded];

    CGFloat cellHeight = 0;
    if (self.status.picture) { // 有配图
        cellHeight = CGRectGetMaxY(self.pictureImageView.frame) + 10;
    } else { // 无配图
        cellHeight = CGRectGetMaxY(self.text_Label.frame) + 10;
    }
    return cellHeight;

}
@end
