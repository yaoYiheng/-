//
//  ViewController.m
//  16_11_19_UIApplication功能
//
//  Created by 姚懿恒 on 2016/11/19.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"====");
}
#pragma mark 更改角标数字
- (IBAction)bageChange {
    //拿到UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];

    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];

    [app registerUserNotificationSettings:notice];

    //更改显示的角标的数字
    app.applicationIconBadgeNumber = 10;
    /**
     以上方法适用于iOS10之前, 之后的做法还需寻找
     */
    
}
#pragma mark 更改网络显示状态
- (IBAction)networkStateChange {
    //拿到UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = !app.networkActivityIndicatorVisible;
}
#pragma mark 隐藏状态栏
- (IBAction)hideStatusBar {
    //拿到UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
//    app.statusBarHidden = !app.isStatusBarHidden;
    [app setStatusBarHidden:!app.isStatusBarHidden animated:YES];
}
#pragma mark 打开网页
- (IBAction)openURL:(id)sender {
    //拿到UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"www.google.com"];
    [app openURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
