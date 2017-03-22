//
//  YYHTagCellTableViewCell.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/22.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTagCellTableViewCell.h"
#import "YYHTagItem.h"
#import <UIImageView+WebCache.h>
@interface YYHTagCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation YYHTagCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置头像为圆形
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setTagItem:(YYHTagItem *)tagItem{
    _tagItem = tagItem;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:tagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeLabel.text = tagItem.theme_name;
    self.countLabel.text = [NSString stringWithFormat:@"%@人订阅", tagItem.sub_number];

}

@end
