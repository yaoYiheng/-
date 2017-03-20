//
//  YYHAdViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/20.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "YYHAdViewController.h"
#import <AFNetworking/AFNetworking.h>

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
/*
    发送请求-> 查看接口文档-> 发送get请求->
    报错"Request failed: unacceptable content-type: text/html"->
    分析: AFN默认采用JSON的解析方案, 告诉AFN能够接受text/html类型的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"]; ->
            
                    请求数据---->解析数据
    已成功接收到来自服务器的数据->将从服务器请求到的数据转换为plist文件->
 */
    //加载广告数据.
    [self configureAdData];

}

/**
 根据屏幕适配图片
 */
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


/**
 加载广告数据
 */
-(void)configureAdData{

    //创建AFN会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


    //告诉AFN能够接受text/html类型的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    NSDictionary *parameters = @{@"code2":code2};

    //2.发送GET请求
    /*
     第一个参数:请求路径(不包含参数).NSString
     第二个参数:字典(发送给服务器的数据~参数)
     第三个参数:progress 进度回调
     第四个参数:success 成功回调
     task:请求任务
     responseObject:响应体信息(JSON--->OC对象)
     第五个参数:failure 失败回调
     error:错误信息
     响应头:task.response
     */
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];

}

@end
