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
    //设置播放次数
    if (topic.playcount > 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.2f万播放",topic.playcount / 10000.0];

    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",topic.playcount ];
    }

    ///设置播放时长
    // %02d : 占据2位，多余的空位用0填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", topic.voicetime / 60, topic.voicetime % 60];




    //AFNetworkReachabilityManager, 网络连接状态管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    //设置图片
    //如果已下载了大图就直接赋值
    UIImage *placeHolder = nil;

    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];

    if (originalImage) {
        self.imageView.image = originalImage;
    }
    else{
        //如果没有下载过原图, 需要根据用户当前的网络状况, 决定下什么图
        if (manager.isReachableViaWiFi) {//wifi情况
            //下载大图
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeHolder];
        }
        else if (manager.isReachableViaWWAN){//是自己带的网络
            //从配置项中获取用户设置
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            //用户同意哪怕是在3g4g的网络情况下也下载大图
            BOOL downloadOriginImageWhen3GOr4G;
            if(downloadOriginImageWhen3GOr4G){
                //下载大图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeHolder];
            }
            else{
                //下载小图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeHolder];
            }

        }else{
            //没有可用网络
            //获取缩略图
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
            if(thumbnailImage){
                //显示缩略图
                self.imageView.image = thumbnailImage;
            }
            else{
//                显示占位图
                self.imageView.image = placeHolder;

            }

        }
    }

}
@end
