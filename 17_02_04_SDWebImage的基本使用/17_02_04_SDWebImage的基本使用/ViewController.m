//
//  ViewController.m
//  17_02_04_SDWebImage的基本使用
//
//  Created by 姚懿恒 on 2017/2/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    [self download1];
}
//1.下载图片且需要获取下载进度
//内存缓存&磁盘缓存
- (void)download1{

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.hanhande.com/files/121010/1283568_172701_4988.jpg"] placeholderImage:[UIImage imageNamed:@"Snip20160221_306"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"%f", 1.0 * receivedSize / expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = image;
        switch (cacheType) {
            case SDImageCacheTypeNone:
                NSLog(@"直接下载");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"磁盘缓存");
                break;
            case SDImageCacheTypeMemory:
                NSLog(@"内存缓存");
                break;
            default:
                break;
        }
    }];
}


/**
 通过单例对象SDWebImageManager
 只需要简单获得一张图片
 //内存缓存&磁盘缓存
 */
- (void)download2{
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"http://pic.hanhande.com/files/121010/1283568_172701_4988.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.imageView.image = image;
    }];
}

//3.不需要任何的缓存处理
//没有做任何缓存处理|
-(void)download3
{

    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"http://pic.hanhande.com/files/121010/1283568_172701_4988.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {


        //data:图片的二进制数据
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {

        //该block是在子线程中, 刷新UI的操作需要回到主线程.
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];

    }];
}


@end
