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
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
@interface YYHShowBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
/** <#comments#>*/
@property (nonatomic, weak) UIScrollView *scrollView;
/** <#comments#>*/
@property (nonatomic, weak) UIImageView *imageView;

- (PHAssetCollection *)createdAssetCollection;
- (PHFetchResult <PHAsset *> *)createdAsset;

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

    //根据相册的授权状态, 决定是否保存相片到相册
    /*
     PHAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
     PHAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
     // The user cannot change this application’s status, possibly due to active restrictions
     //   such as parental controls being in place.
     PHAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
     PHAuthorizationStatusAuthorized         // User has authorized this application to access photos data.
     */

    //1. 获取当前相册的授权状态
    PHAuthorizationStatus previousStatus = [PHPhotoLibrary authorizationStatus];

    //只有当第一次访问相册时, 其状态才会为0, 这时会弹出是否允许访问
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //如果之前设置过拒绝并且想再次访问相册时.
        if (status == PHAuthorizationStatusDenied && previousStatus != PHAuthorizationStatusNotDetermined) {
         UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"请更改访问相册权限" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

            [alerVC addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"去系统更改");
            }]];

            [self presentViewController:alerVC animated:YES completion:nil];
        }
        else if (status == PHAuthorizationStatusAuthorized){//授权
            [self savePictureToAlbum];
        }
        else if (status == PHAuthorizationStatusRestricted){
            
        }
    }];



}
- (void)savePictureToAlbum{
    //使用Photos框架进行相片/相册的增删改查

    NSError *error = nil;

    //1. 将图片保存到Camera Roll -> 获取图片
    PHFetchResult *result = self.createdAsset;
    if (result == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }



    //2. [创建自定义相册到 [照片] 应用]  -> 获取自定义相册.

    PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
    if(createdAssetCollection == nil){
        [SVProgressHUD showErrorWithStatus:@"获取相册失败"];
    }


    //3. 在自定义相册中同样显示保存的图片
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //将图片插入到自定义相册的第一个位置
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];

        [request insertAssets:result atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];

    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }
    else{
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }

}

- (PHFetchResult <PHAsset *> *)createdAsset{

    NSError *error = nil;

    __block NSString *assetID = nil;
    //1. 将图片保存到Camera Roll
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];

    if (error) return nil;

    PHFetchResult *reslut = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];

    return reslut;


}
/**
 获得自定义相册
 */
- (PHAssetCollection *)createdAssetCollection{
    //2. 创建自定义相册到 [照片] 应用


    //获取应用名
    NSString *appTitle = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];


    //获取自定义相册的集合
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];

    PHAssetCollection *createdAssetColllection = nil;

    //判断是否已创建过同名的文件夹
    for (createdAssetColllection in result) {
        if ([createdAssetColllection.localizedTitle isEqualToString:appTitle]) {

            return createdAssetColllection;
        }
    }

    NSError *error = nil;
    //如果没有创建过该应用对应的相册, 就创建一个与应用名相对应的相册
    __block NSString *assetCollectID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{

        //通过id创建相册
        assetCollectID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appTitle].placeholderForCreatedAssetCollection.localIdentifier;


    } error:&error];

    if (error) return nil;

    //通过id获取并返回相册
    createdAssetColllection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectID] options:nil].firstObject;

    return createdAssetColllection;

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
