//
//  ViewController.m
//  17_04_19_多图的选择
//
//  Created by 姚懿恒 on 2017/4/19.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import <CTAssetsPickerController.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,CTAssetsPickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)multiSelect {


    //点击后, 弹出相片选择页面,选择多张相片, 使用第三方框架
    // request authorization status
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{

            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];

            picker.doneButtonTitle = @"选择";
            picker.showsEmptyAlbums = NO;
//            picker.showsNumberOfAssets = YES;
            //是否按顺序显示
            picker.showsSelectionIndex = NO;
//            picker.selectedAsses;

            // set delegate
            picker.delegate = self;

            // Optionally present picker as a form sheet on iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;

            // present picker
            [self presentViewController:picker animated:YES completion:nil];
        });
    }];


}
- (IBAction)singleSelect {
    //使用系统自带图片选择器
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    /*
        选择相片来源, 可以是从相机或是相册.
     UIImagePickerControllerSourceTypePhotoLibrary,
     UIImagePickerControllerSourceTypeCamera,
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     */
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - -------CTAssetsPickerControllerDelegate--------------

/**
 在该方法中控制最大选中张数
 */
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{

    NSInteger max = 3;

    // show alert gracefully
    if (picker.selectedAssets.count >= max)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Attention"
                                            message:[NSString stringWithFormat:@"Please select not more than %ld assets", (long)max]
                                     preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];

        [alert addAction:action];

        [picker presentViewController:alert animated:YES completion:nil];
    }

    // limit selection to max
    return (picker.selectedAssets.count < max);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    [picker dismissViewControllerAnimated:YES completion:nil];


    PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;

    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / [UIScreen mainScreen].scale, asset.pixelHeight / [UIScreen mainScreen].scale);

        NSLog(@"%f", [UIScreen mainScreen].scale);
        //向图片管理者发送请求, 从asset中请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {

            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = result;

            imageView.frame = CGRectMake(i % 3 * (100 + 10), i / 3 * (100 + 10), 100, 100);

            [self.view addSubview:imageView];

        }];

    }




}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@", info);
    [picker dismissViewControllerAnimated:YES completion:nil];

    //创建一个imageView以显示
    UIImageView *imageView = [[UIImageView alloc] init];

    imageView.image = info[@"UIImagePickerControllerOriginalImage"];
    imageView.frame = CGRectMake(0, 0, 300, 300);


    [self.view addSubview:imageView];

}


@end
