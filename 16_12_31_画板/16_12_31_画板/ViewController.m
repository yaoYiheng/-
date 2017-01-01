//
//  ViewController.m
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2016/12/31.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "YHImageView.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, YHImageViewDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

#pragma mark -画板功能

- (IBAction)allClear:(UIBarButtonItem *)sender {
    [self.drawView allClear];
}


- (IBAction)undo:(UIBarButtonItem *)sender {
    [self.drawView undo];
}
- (IBAction)eraser:(UIBarButtonItem *)sender {
    [self.drawView eraser];
}

- (IBAction)setLineWidth:(UISlider *)sender {
    [self.drawView setLineWidths:sender.value];
}
- (IBAction)setLineColor:(UIButton *)sender {
    [self.drawView setLineColors:sender.backgroundColor];

}
#pragma mark -从相册中选出一张图片
- (IBAction)photoFromAlbum:(UIBarButtonItem *)sender {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

    [self presentViewController:imagePicker animated:YES completion:nil];

}

/**
 从相册中选出一张图片后, 会来到该方法

 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    //通过传递来的字典文件, 拿到传来的图片
    UIImage *imageFromAlbum = info[UIImagePickerControllerOriginalImage];
//    self.drawView.image = imageFromAlbum;

    //创建一个新的UIView, 在该view上完成对传入的图片的拖拽, 旋转以及缩放
    YHImageView *handleImageView = [[YHImageView alloc] init];
    handleImageView.frame = self.drawView.frame;
    handleImageView.passedImage = imageFromAlbum;

    handleImageView.delegate = self;
    [self.view addSubview:handleImageView];


    //使系统相册以modal形式消失.
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 实现代理方法: 长按后 将从系统相册里加载的并按成了拖拽, 旋转及缩放后的图片, 赋值给 画板的

 */
- (void)YHImageView:(YHImageView *)imageView image:(UIImage *)image{
    self.drawView.image = image;
}
#pragma mark -保存图片到相册
- (IBAction)savePicture:(UIBarButtonItem *)sender {

    //只有当有绘制时, 才保存.
    if (self.drawView.Drawing) {
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0);

        //获取上下文
        CGContextRef currentContext = UIGraphicsGetCurrentContext();

        //渲染到上下文
        [self.drawView.layer renderInContext:currentContext];

        //获取新图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

        //关闭上下文
        UIGraphicsEndImageContext();

        //将新图片保存到系统相册中, 需要调用以下方法, 该方法的第三个参数, 必须要按照其规定的格式书写
        UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }

}

/**
 将图片保存到系统相册后, 来到该方法, 完成相关操作
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    //加入弹窗提示保存成功
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];

    [alterController addAction:confirmAction];
    [self presentViewController:alterController animated:YES completion:nil];

}
#pragma mark -view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 隐藏顶部状态栏
 */
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
