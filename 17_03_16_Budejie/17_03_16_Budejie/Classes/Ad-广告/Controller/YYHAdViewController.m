//
//  YYHAdViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHAdViewController.h"

@interface YYHAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIView *placeHolderView;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@end

@implementation YYHAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //不同的屏幕加载不同尺寸的图片
    /*
     // 6p:LaunchImage-800-Portrait-736h@3x.png
     // 6:LaunchImage-800-667h@2x.png
     // 5:LaunchImage-568h@2x.png
     // 4s:LaunchImage@2x.png
     */
    //加载图片.
    [self configureLaunchImage];

}
- (void)configureLaunchImage{


    UIImage *launchImage = nil;
    if (iphone6P)
    {
        launchImage  = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    else if (iphone6)
    {
        launchImage = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }
    else if (iphone5)
    {
        launchImage = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    }
    else if (iphone4)
    {
        launchImage = [UIImage imageNamed:@"LaunchImage@2x"];
    }

    self.adImageView.image = launchImage;
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


}



@end
