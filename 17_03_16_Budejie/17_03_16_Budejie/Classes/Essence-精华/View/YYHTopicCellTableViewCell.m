//
//  YYHTopicCellTableViewCell.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/7.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicCellTableViewCell.h"
#import "YYHTopicsItem.h"
#import <UIImageView+WebCache.h>


@interface YYHTopicCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end


@implementation YYHTopicCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setTopic:(YYHTopicsItem *)topic{
    _topic = topic;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;


//    if (topic.ding > 10000) {
//        [self.dingButton setTitle:[NSString stringWithFormat:@"%.1f万", topic.ding / 10000.0] forState:UIControlStateNormal];
//    }
//    else if (topic.ding > 0)
//    {
//        [self.dingButton setTitle:[NSString stringWithFormat:@"%ld", topic.ding] forState:UIControlStateNormal];
//    }
//    else{
//        [self.dingButton setTitle:@"顶" forState:UIControlStateNormal];
//    }

    [self setupTitle:self.dingButton count:topic.ding title:@"顶"];
    [self setupTitle:self.caiButton count:topic.cai title:@"踩"];
    [self setupTitle:self.shareButton count:topic.repost title:@"分享"];
    [self setupTitle:self.commentButton count:topic.comment title:@"评论"];

}

- (void)setupTitle:(UIButton *)button count:(NSInteger)count title:(NSString *)title{

    if (count > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", count / 10000.0] forState:UIControlStateNormal];
    }
    else if (count > 0)
    {
        [button setTitle:[NSString stringWithFormat:@"%ld", count] forState:UIControlStateNormal];
    }
    else{
        [button setTitle:title forState:UIControlStateNormal];
    }
}
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
