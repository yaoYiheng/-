//
//  YYHTopicVideoView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "YYHTopicsItem.h"

#import <AFNetworking.h>
#import "UIImageView+YYHDownImage.h"

#import <AFNetworking.h>
#import "YYHShowVideoViewController.h"

@interface YYHTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *placeHolderView;

@end

@implementation YYHTopicVideoView
- (void)awakeFromNib{
    [super awakeFromNib];

    self.autoresizingMask = NO;

    //为占位图片添加点击手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideo)];

    [self.imageView addGestureRecognizer:tapGes];

    //允许imageView接收用户点击
    self.imageView.userInteractionEnabled = YES;

}
- (void)showVideo{
    YYHFunc
    YYHShowVideoViewController *videoVC = [[YYHShowVideoViewController alloc] init];

    videoVC.topic = self.topic;
    [self.window.rootViewController presentViewController:videoVC animated:YES completion:nil];
}

+ (instancetype)yyhTopicVideoViewFromNib{
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
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", topic.videotime / 60, topic.videotime % 60];





    //将根据网络状态加载原图或是缩略图的方法添加到分类当中, 并在设置完图片后, 根据图片的有无设置placeHolderView的隐藏或是显示.

    self.placeHolderView.hidden = NO;

    [self.imageView yyh_setOriginalImageWithURL:topic.image1 thumbmailImageWithURL:topic.image0 placeHolderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(!image) return;

        self.placeHolderView.hidden = YES;
    }];


}
@end
