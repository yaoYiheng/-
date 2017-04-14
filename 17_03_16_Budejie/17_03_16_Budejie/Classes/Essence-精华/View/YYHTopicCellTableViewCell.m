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
#import "YYHTopicVoiceView.h"
#import "YYHTopicVideoView.h"
#import "YYHTopicPictutrView.h"


@interface YYHTopicCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;


//中间的view
/** voiceView*/
@property (nonatomic, weak) YYHTopicVoiceView *voiceView;
/** videoView*/
@property (nonatomic, weak) YYHTopicVideoView *videoView;
/** 图片*/
@property (nonatomic, weak) YYHTopicPictutrView *pictureView;

@end


@implementation YYHTopicCellTableViewCell
#pragma mark - -------懒加载--------------
- (YYHTopicVoiceView *)voiceView{
    if (!_voiceView) {
        YYHTopicVoiceView *view = [YYHTopicVoiceView yyhTopicVoiceFromNib];
        _voiceView = view;
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (YYHTopicVideoView *)videoView{
    if (!_videoView) {
        YYHTopicVideoView *view = [YYHTopicVideoView yyhTopicVideoViewFromNib];
        _videoView = view;
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}
- (YYHTopicPictutrView *)pictureView{
    if (!_pictureView) {
        YYHTopicPictutrView *view = [YYHTopicPictutrView yyhTopicPictutrViewFromNib];
        _pictureView = view;
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setTopic:(YYHTopicsItem *)topic{
    _topic = topic;
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置头像圆角
    /*
        方法一:直接修改控件的圆角半径以及layer.masksToBounds = YES;
        方法二:通过图形上下文裁剪, 并且可以将该方法添加到分类中
     由于占位图片也需要设置圆角可以在分类中添加类方法
     */
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage yyh_circleImageNamed:@"defaultUserIcon"] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        //如果图片下载失败,就直接返回, 显示占位图片
        if(error) return;
//        self.profileImageView.layer.masksToBounds = YES;
//        self.profileImageView.layer.cornerRadius = self.profileImageView.yyh_height / 2;

        //编写分类方法时, 先看外界怎么调用方便, 再决定怎么写
        self.profileImageView.image = [image yyh_circleImage];

    }];
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

    //设置最热评论内容
    if (topic.top_cmt.count) {//如果数组中有值
        self.topCommentView.hidden = NO;

        NSDictionary *topComment = topic.top_cmt.firstObject;
        NSString *content = topComment[@"content"];
        //判断如果内容为0, 则语音信息
        if(content.length == 0){
            content = @"[语音评论]";
        }
        NSString *userName = topComment[@"user"][@"username"];
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@ : %@", userName, content];
    }
    else{
        self.topCommentView.hidden = YES;
    }

    //根据不同类型, 加载相应的控件
    if (topic.type == YYHTopicTypeVideo) {

        //防止循环利用时, 出现的错乱
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;

        self.videoView.topic = topic;

    }
    else if (topic.type == YYHTopicTypeVoice){
        //防止循环利用时, 出现的错乱
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        //添加声音控件模型
        self.voiceView.topic = topic;
    }
    else if (topic.type == YYHTopicTypePicture){
        //防止循环利用时, 出现的错乱
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        //添加图片控件
        self.pictureView.topic = topic;
    }
    else if (topic.type == YYHTopicTypeWord){

        //防止循环利用时, 出现的错乱
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }

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
    //如果想要做到cell悬浮在中间的效果, 可以通过增加x值, 并减少宽度
//    frame.origin.x += YYHMargin;
//    frame.size.width -= 2 * YYHMargin;
    frame.size.height -= YYHMargin;
    [super setFrame:frame];
}
- (void)layoutSubviews{
    [super layoutSubviews];

    //
    if (self.topic.type == YYHTopicTypeVoice) {
        self.voiceView.frame = self.topic.middleFrame;

    }
    else if (self.topic.type == YYHTopicTypePicture){
        self.pictureView.frame = self.topic.middleFrame;
    }
    else if (self.topic.type == YYHTopicTypeVideo){
        self.videoView.frame = self.topic.middleFrame;
    }
}
@end
