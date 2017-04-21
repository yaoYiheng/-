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

- (void)yyh_setOriginalImageWithURL:(NSString *)originalURL thumbmailImageWithURL:(NSString *)thumbmailURL placeHolderImage:(UIImage *)placeHolder completed:(nullable SDExternalCompletionBlock)completedBlock {
    //AFNetworkReachabilityManager, 网络连接状态管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    NSLog(@"%d", manager.isReachableViaWiFi);
    //设置图片
    //如果已下载了大图就直接赋值
//    UIImage *placeHolder = nil;

    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalURL];

    if (originalImage) {

        /*如果使用sd, 最好不要直接设置图片, 而是通过sd框架提供的方法进行设置, 不然会出现图片错乱显示的问题, 原因是因为cell循环利用的
         关系, 当cell循环到下一个item对象时, 会显示对应cell的图片, 但是之前cell的图片请求依然存在, 当图片下载完之后, 又会重新设置到
         当前显示的cell上, 出现bug.
         
         sd在
         */

//        self.image = originalImage;
//
//        completedBlock(originalImage, nil, 0, [NSURL URLWithString:originalURL]);
        /*
            利用该方法为imageView设置图片还有一个好处就是会将当前imageView的请求取消, 在进行接下来的操作.
         */
        [self sd_setImageWithURL:[NSURL URLWithString:originalURL] placeholderImage:placeHolder completed:completedBlock];
    }
    else{
        //如果没有下载过原图, 需要根据用户当前的网络状况, 决定下什么图
        if (manager.isReachableViaWiFi) {//wifi情况
            //下载大图
            [self sd_setImageWithURL:[NSURL URLWithString:originalURL] placeholderImage:placeHolder options:0 completed:completedBlock];
        }
        else if (manager.isReachableViaWWAN){//是自己带的网络
            //从配置项中获取用户设置
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            //用户同意哪怕是在3g4g的网络情况下也下载大图
            BOOL downloadOriginImageWhen3GOr4G;
            if(downloadOriginImageWhen3GOr4G){
                //下载大图
                [self sd_setImageWithURL:[NSURL URLWithString:originalURL] placeholderImage:placeHolder completed:completedBlock] ;
            }
            else{
                //下载小图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbmailURL] placeholderImage:placeHolder completed:completedBlock];
            }

        }else{
            //没有可用网络
            //获取缩略图
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbmailURL];
            if(thumbnailImage){
                //显示缩略图
//                self.image = thumbnailImage;
                [self sd_setImageWithURL:[NSURL URLWithString:thumbmailURL] placeholderImage:placeHolder completed:completedBlock];

            }
            else{
                //显示占位图, 断网且没有缩略图的情况下, 不再发送请求并设置占位图.
                [self sd_setImageWithURL:nil placeholderImage:placeHolder completed:completedBlock];
//                self.image = placeHolder;

            }
            
        }
    }
}


@end
