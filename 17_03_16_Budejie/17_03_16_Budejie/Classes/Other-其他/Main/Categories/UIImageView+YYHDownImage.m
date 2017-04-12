//
//  UIImageView+YYHDownImage.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIImageView+YYHDownImage.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@implementation UIImageView (YYHDownImage)

- (void)yyh_setOriginalImageWithURL:(NSString *)originalURL thumbmailImageWithURL:(NSString *)thumbmailURL placeHolderImage:(UIImage *)placeHolder completed:(void (^)(UIImage *))completed{
    //AFNetworkReachabilityManager, 网络连接状态管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    //设置图片
    //如果已下载了大图就直接赋值
//    UIImage *placeHolder = nil;

    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalURL];

    if (originalImage) {
        self.image = originalImage;
    }
    else{
        //如果没有下载过原图, 需要根据用户当前的网络状况, 决定下什么图
        if (manager.isReachableViaWiFi) {//wifi情况
            //下载大图
            [self sd_setImageWithURL:[NSURL URLWithString:originalURL] placeholderImage:placeHolder];
        }
        else if (manager.isReachableViaWWAN){//是自己带的网络
            //从配置项中获取用户设置
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            //用户同意哪怕是在3g4g的网络情况下也下载大图
            BOOL downloadOriginImageWhen3GOr4G;
            if(downloadOriginImageWhen3GOr4G){
                //下载大图
                [self sd_setImageWithURL:[NSURL URLWithString:originalURL] placeholderImage:placeHolder];
            }
            else{
                //下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbmailURL] placeholderImage:placeHolder];
            }

        }else{
            //没有可用网络
            //获取缩略图
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbmailURL];
            if(thumbnailImage){
                //显示缩略图
                self.image = thumbnailImage;
            }
            else{
                //                显示占位图
                self.image = placeHolder;
                
            }
            
        }
    }
}
@end
