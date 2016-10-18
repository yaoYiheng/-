//
//  ViewController.m
//  16_10_12_按钮相关
//
//  Created by 姚懿恒 on 2016/10/12.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+YHExtention.h"

@interface ViewController ()
/** 按钮*/
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建image对象
    UIImage *image = [UIImage resezableImageWithImageNage:@"chat_send_nor"];
    //拿到image对象宽高
//    CGFloat imageWidth = image.size.width;
//    CGFloat imageHeight = image.size.height;

    //方式一
//    UIImage *resezableImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageHeight * 0.5, imageWidth * 0.5, imageHeight * 0.5 -1, imageWidth * 0.5 - 1)];


    //方式二
//    UIImage *resezableImage = [image stretchableImageWithLeftCapWidth:imageWidth * 0.5 topCapHeight:imageHeight * 0.5];
    [self.button setBackgroundImage:image forState:UIControlStateNormal];

//    [self.button2 setBackgroundImage:resezableImage forState:UIControlStateNormal];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
