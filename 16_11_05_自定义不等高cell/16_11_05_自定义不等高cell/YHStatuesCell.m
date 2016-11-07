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
@property (nonatomic, weak) UIImageView *pictureImageView;
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

        /**头像图片 */
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;

        /**图片 */
        UIImageView *picutreImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:picutreImageView];
        self.pictureImageView = picutreImageView;

        /**VIP */
        UIImageView *vipImageView = [[UIImageView alloc] init];
        vipImageView.image = [UIImage imageNamed:@"vip"];
        //设置图片居中显示
        vipImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:vipImageView];
        self.vipImageView = vipImageView;

        /**昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        //设置显示的字体大小
        nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;

        /**微博内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}
#pragma mark 在该方法中设置子控件宽高与位置
- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat space = 10;

    /**头像图片 */
    CGFloat iconX = space;
    CGFloat iconY = space;
    CGFloat iconWH = 30;
    self.iconImageView.frame = CGRectMake(iconX, iconY, iconWH, iconWH);

    /**昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconImageView.frame) + space;
    CGFloat nameY = space;

    NSDictionary *nameAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};

    CGSize nameSize = [self.statuses.name sizeWithAttributes:nameAttribute];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;

    self.nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);

    /**微博内容 */
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(self.iconImageView.frame) + space;
    CGFloat contentW = self.contentView.frame.size.width - 2 *space;

    NSDictionary *contentAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);


    CGFloat contentH = [self.statuses.text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttribute context:nil].size.height;

    self.contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);

    /**VIP */
    if (self.statuses.vip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabel.frame) + space;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameH;
        self.vipImageView.frame = CGRectMake(vipX, vipY, vipW, vipH);
    }


    /**微博图片 */
    if (self.pictureImageView) {
        CGFloat pictureX = space;
        CGFloat pictureY = CGRectGetMaxY(self.contentLabel.frame) + space;
        CGFloat pictureWH = 150;
        self.pictureImageView.frame = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);
    }


}

-(void)setStatuses:(YHStatus *)statuses{

    _statuses = statuses;

    self.iconImageView.image = [UIImage imageNamed:statuses.icon];
    self.nameLabel.text = statuses.name;
    self.contentLabel.text = statuses.text;

    if (statuses.vip) { //如果是VIP就显示会员图片, 并设置文字颜色
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    if (statuses.picture) {
        self.pictureImageView.hidden = NO;
        self.pictureImageView.image = [UIImage imageNamed:statuses.picture];
    }
    else{
        self.pictureImageView.hidden = YES;
    }

}

@end
