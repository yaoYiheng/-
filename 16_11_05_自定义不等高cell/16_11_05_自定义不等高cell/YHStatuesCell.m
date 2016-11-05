//
//  YHStatuesCell.m
//  16_11_05_自定义不等高cell
//
//  Created by 姚懿恒 on 2016/11/5.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHStatuesCell.h"
#import "YHStatus.h"
@interface YHStatuesCell ()

/** 头像图片*/
@property (nonatomic, weak) UIImageView *iconImageView;
/** 昵称*/
@property (nonatomic, weak) UILabel *nameLabel;
/** 内容*/
@property (nonatomic, weak) UILabel *contentLabel;
/** 图片*/
@property (nonatomic, weak) UIImageView *picutreImageView;
/** Vip*/
@property (nonatomic, weak) UIImageView *vipImageView;

@end

@implementation YHStatuesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;

        UIImageView *picutreImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:picutreImageView];
        self.picutreImageView = picutreImageView;

        UIImageView *vipImageView = [[UIImageView alloc] init];
        vipImageView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:vipImageView];
        self.vipImageView = vipImageView;

        UILabel *nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;

        UILabel *contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];


}

-(void)setStatuses:(YHStatus *)statuses{

    _statuses = statuses;

    self.iconImageView.image = [UIImage imageNamed:statuses.icon];
    self.nameLabel.text = statuses.name;
    self.contentLabel.text = statuses.text;

    if (statuses.vip) {
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{

    }

}

@end
