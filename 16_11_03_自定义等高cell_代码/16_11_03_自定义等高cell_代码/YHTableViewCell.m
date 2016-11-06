//
//  YHTableViewCell.m
//  16_11_03_自定义等高cell_代码
//
//  Created by 姚懿恒 on 2016/11/3.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHTableViewCell.h"
#import "YHTgCell.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

@interface YHTableViewCell()
/** 图片*/
@property (nonatomic, weak) UIImageView *iconImageView;

/** 标题*/
@property (nonatomic, weak) UILabel *titleLabel;
/** 价格*/
@property (nonatomic, weak) UILabel *priceLabel;

/** 购买数*/
@property (nonatomic, weak) UILabel *buyCountLabel;

@end

@implementation YHTableViewCell

#pragma mark 重写init方法创建并添加所需要的子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        CGFloat space = 10;
        //初始化子控件, 并将子控件们都添加到 self.contentView 中
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView; //不要忘记这一步
        [iconImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(space);
            make.bottom.equalTo(self.contentView.bottom).offset(-space);
            make.width.equalTo(80);
        }];


        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.top);
            make.left.equalTo(iconImageView.right).offset(space);
            make.right.equalTo(self.contentView.right).offset(-space);

        }];

        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        [priceLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.right).offset(space);
            make.bottom.equalTo(self.contentView).offset(-space);

        }];

        UILabel *buyCountLabel = [[UILabel alloc] init];
        buyCountLabel.textAlignment = NSTextAlignmentRight;
        buyCountLabel.font = [UIFont systemFontOfSize:14];
        buyCountLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:buyCountLabel];
        self.buyCountLabel = buyCountLabel;
        [buyCountLabel makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-space);
            make.right.offset(-space);
        }];
    }
    return self;
}

#pragma mark 布局子控件的宽高及位置
- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat space = 10;
    CGFloat contentViewW = self.contentView.frame.size.width;
    CGFloat contentViewH = self.contentView.frame.size.height;
    /** 图标 */
    CGFloat iconX = space;
    CGFloat iconY = space;
    CGFloat iconW = 80;
    CGFloat iconH = contentViewH - 2 * space;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);

    /** 标题 */
    CGFloat titleX = iconX + iconW + space;
    CGFloat titleY = iconY;
    CGFloat titleW = contentViewW - titleX - space;
    CGFloat titleH = 20;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);

    /** 价格 */
    CGFloat priceW = 100;
    CGFloat priceH = 15;
    CGFloat priceX = titleX;
    CGFloat priceY = iconY + iconH - priceH;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);

    /** 购买数 */
    CGFloat buyW = 150;
    CGFloat buyH = 14;
    CGFloat buyX = contentViewW - buyW - space;
    CGFloat buyY = iconY + iconH - buyH;
    self.buyCountLabel.frame = CGRectMake(buyX, buyY, buyW, buyH);

}

#pragma mark 重写set方法, 在这里设置数据.
- (void)setTgCell:(YHTgCell *)tgCell{
    _tgCell = tgCell;

    self.iconImageView.image = [UIImage imageNamed:tgCell.icon];
    self.titleLabel.text = tgCell.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", tgCell.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", tgCell.buyCount];
}




@end
