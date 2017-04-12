//
//  YYHTopicVoiceView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "YYHTopicsItem.h"
#import <AFNetworking.h>
#import "UIImageView+YYHDownImage.h"

@interface YYHTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderView;

@end

@implementation YYHTopicVoiceView

+ (instancetype)yyhTopicVoiceFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setTopic:(YYHTopicsItem *)topic{
    _topic = topic;
    //设置播放次数
    if (topic.playcount > 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.2f万播放",topic.playcount / 10000.0];

    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",topic.playcount ];
    }

    ///设置播放时长
    // %02d : 占据2位，多余的空位用0填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", topic.voicetime / 60, topic.voicetime % 60];




    //将根据网络状态加载原图或是缩略图的方法添加到分类当中, 并在设置完图片后, 根据图片的有无设置placeHolderView的隐藏或是显示.

    self.placeHolderView.hidden = NO;
    [self.imageView yyh_setOriginalImageWithURL:topic.image1 thumbmailImageWithURL:topic.image0 placeHolderImage:nil completed:^(UIImage *image) {
        if (!image) {
            return;
        }
        self.placeHolderView.hidden = YES;
    }];
    
    
}
@end
