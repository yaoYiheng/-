//
//  YYHShowBigPictureViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHShowBigPictureViewController.h"
#import "YYHTopicsItem.h"
#import <UIImageView+WebCache.h>
@interface YYHShowBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
/** <#comments#>*/
@property (nonatomic, weak) UIScrollView *scrollView;
/** <#comments#>*/
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation YYHShowBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveButton.layer.cornerRadius = self.saveButton.yyh_height * 0.5;

    [self configureScrollView];

    [self configureImageView];



}
#pragma mark - -------配置子控件--------------
- (void)configureScrollView{
    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;

    //为该srollView添加点按手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [scrollView addGestureRecognizer:tapGes];

    //将scrollView插入到最下方.
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;

}
- (void)configureImageView{
    //添加imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;

    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //下载图片后要做的事
        if(!image) return;
        self.saveButton.enabled = YES;

    }];

    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = YYhScreenW;
    CGFloat imageViewH = self.topic.height * imageViewW / self.topic.width;

    imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    //根据传入的模型决定imageView的frame.
    if (imageView.yyh_height > YYHScreenH) {//需要全屏显示
        //如果图片高度大于屏幕高度, 就需要设置scrollView的滚动范围为图片大小
        _scrollView.contentSize = CGSizeMake(0, imageViewH);

    }else{
        //设置图片居中显示
        imageView.yyh_centerY = 0.5 * _scrollView.yyh_height;
    }

    [self.scrollView addSubview:imageView];

    self.imageView = imageView;

    //放大图片
    CGFloat maxScale = self.topic.width / YYhScreenW;
    if (maxScale > 1) {
        self.scrollView.maximumZoomScale = maxScale;
    }
}
#pragma mark - -------UIScrollViewDelegate--------------
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
#pragma mark - -------点击按钮--------------
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)savePicture:(UIButton *)sender {


}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

}

/**
 调用C函数保存一张图片
 */
- (void)savePictureViaC{
    /**
     调用该函数, 将一张相片保存到系统相册

     @param image 待保存的图片
     @param completionTarget 目标. 一般为self
     @param completionSelector 调用的方法, 需要参照- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo 格式
     @param contextInfo 相关信息 可为nil
     @return void
     */
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    /*
     iOS10之后访问相册, 需要在info.plist文件中添加一个NSPhotoLibraryUsageDescription的key, 否则
     程序直接crash.
     This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSPhotoLibraryUsageDescription key with a string value explaining to the user how the app uses this data.

     */
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
@end
