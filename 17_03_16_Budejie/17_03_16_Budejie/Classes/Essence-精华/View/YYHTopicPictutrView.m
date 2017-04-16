//
//  YYHTopicPictutrView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTopicPictutrView.h"
#import "YYHTopicsItem.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+YYHDownImage.h"
#import "YYHShowBigPictureViewController.h"

@interface YYHTopicPictutrView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *showBigPictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *placeHolderView;

@end

@implementation YYHTopicPictutrView

+ (instancetype)yyhTopicPictutrViewFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;

    //设置点击查看大图的title跟image的间距
    self.showBigPictureButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    self.showBigPictureButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    self.imageView.userInteractionEnabled = YES;
    self.showBigPictureButton.userInteractionEnabled = NO;
    //为imageView添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)];
    [self.imageView addGestureRecognizer:tapGes];
}

/**
 点击查看大图, 以modal形式
 */
- (void)showBigPicture{

    YYHShowBigPictureViewController *showBigVC = [[YYHShowBigPictureViewController alloc] init];

    showBigVC.topic = self.topic;
    [self.window.rootViewController presentViewController:showBigVC animated:YES completion:nil];

}
- (void)setTopic:(YYHTopicsItem *)topic{
    _topic = topic;


    self.placeHolderView.hidden = NO;

    [self.imageView yyh_setOriginalImageWithURL:topic.image1 thumbmailImageWithURL:topic.image0 placeHolderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!image) return;
        self.placeHolderView.hidden = YES;

        // 处理超长图片的大小, 修复第一次加载长图无法填充的bug.
        /*
            原因: 在子线程中下载图片时, 并不会阻塞主线程继续执行接下来的代码.
         */
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;

            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    }];


    //利用根据图片的url进行判断, 设置gif标识与否.
    self.gifImageView.hidden = !topic.is_gif;

    //设置cell数据时, 如果需要做if判断时, 一定要考虑esle的情况, 不然因为循环利用会出现问题
    // 点击查看大图

    //  根据是否是超长图片设置点击查看大图的显示与否.
    if (topic.isBigPicture) { // 超长图
        self.showBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;


    } else {
        self.showBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;

    }


}
@end
