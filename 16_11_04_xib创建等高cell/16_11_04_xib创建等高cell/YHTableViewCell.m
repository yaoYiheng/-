//
//  YHTableViewCell.m
//  16_11_04_xib创建等高cell
//
//  Created by 姚懿恒 on 2016/11/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHTableViewCell.h"
#import "YHTgCell.h"


@interface YHTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation YHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTgCell:(YHTgCell *)tgCell{
    _tgCell = tgCell;
    self.iconImageView.image = [UIImage imageNamed:tgCell.icon];
    self.titleLabel.text = tgCell.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", tgCell.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", tgCell.buyCount];

}

@end
