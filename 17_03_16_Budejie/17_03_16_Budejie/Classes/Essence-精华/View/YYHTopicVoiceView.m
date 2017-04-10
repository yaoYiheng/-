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

@interface YYHTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation YYHTopicVoiceView

+ (instancetype)yyhTopicVoiceFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setTopic:(YYHTopicsItem *)topic{
    _topic = topic;
    if (topic.playcount > 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.2f万播放",topic.playcount / 10000.0];

    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",topic.playcount ];
    }

    // %02d : 占据2位，多余的空位用0填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", topic.voicetime / 60, topic.voicetime % 60];

    //如果已下载了大图就直接赋值
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];

    if (originalImage) {
        self.imageView.image = originalImage;
    }
    else{
        //如果没有下载过原图
    }

}
@end
