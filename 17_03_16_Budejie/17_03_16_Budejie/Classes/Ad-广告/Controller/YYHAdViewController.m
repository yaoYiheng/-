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
#import "YYHADItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "YYHTabBarController.h"

@interface YYHAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIView *placeHolderView;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
/** <#comments#>*/
@property (nonatomic, weak) UIImageView *realImageView;

/** <#comments#>*/
@property (nonatomic, strong) YYHADItem *adItem;
/** 定时器对象*/
@property (nonatomic, weak) NSTimer *timer;
/** <#comments#>*/
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation YYHAdViewController
#pragma mark -----懒加载realImageView-----
- (UIImageView *)realImageView{
    if (!_realImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.placeHolderView addSubview:imageView];
        _realImageView = imageView;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAD)];
        [imageView addGestureRecognizer:tapGest];
        //默认情况下UIImageView不会相应点击
        imageView.userInteractionEnabled = YES;
    }
    return _realImageView;
}

/**
 点击广告后跳转
 */
- (void)tapAD{
    NSURL *adURL = [NSURL URLWithString:self.adItem.ori_curl];

    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:adURL]) {
        [app openURL:adURL];
    }

}
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
            
                    请求数据---->解析数据---->
    已成功接收到来自服务器的数据->将从服务器请求到的数据转换为plist文件->从面向字典开发转化成面向模型开发->设计广告模型->根据需求设计模型->使用MJ框架将字典转为模型->加载模型中的图片->向占位view中添加->为占位view添加一个UIImageView以显示图片->该控件只需要加载一次, 使用懒加载->使用SDWeb加载广告图片->点击广告时跳转->为UIImageView添加点按手势以及点按后会调用的方法-> 使用UIApplication, 进行跳转->为广告添加计时器, 只能显示一定的时间, 时间过后, 直接跳转到主页面, 同时实现点击跳过, 直接进入主页面功能->同时需要销毁定时器.
 */
    //加载广告数据.
    [self configureAdData];

    //添加定时器
    [self addTimer];

}

/**
 添加计时器
 */
-(void)addTimer{
    //1. 创建timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

/**
 倒数进入主页面, 同时修改倒计时显示.
 */
- (void)countDown{
    static int second = 3;

    //倒数到0时. 跳转到tabBarVC
    if (second == 0) {
        [self skipClick];
    }
    second--;
    [self.skipButton setTitle:[NSString stringWithFormat:@"跳过 (%d)", second] forState:UIControlStateNormal];
}

/**
 进入主页面, 销毁控制器
 */
- (IBAction)skipClick {
    YYHTabBarController *tabBarVC = [[YYHTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;

    [self.timer invalidate];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

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
    _manager = manager;

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
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        //解析响应体->从响应体中获取所需要的数据
        /*
            [responseObject[@"ad"] 该key对应的value是一个数组, 且数组中只有一个元素, 取出该元素, 才是所需要的字典
         */
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];

//        NSLog(@"%@", adDict);
        //将该字典文件转换成plist文件保存到项目目录中.
//        [adDict writeToFile:@"/Users/Morris/Documents/iOS/练习代码/17_03_16_Budejie/ad.plist" atomically:YES];

        //字典转模型->需要用到MJ框架->到CocoaPods中添加
        self.adItem = [YYHADItem mj_objectWithKeyValues:adDict];

        //成功获取adItem后, 需要展示adItem中的广告页面.
        NSURL *adURL = [NSURL URLWithString:self.adItem.w_picurl];

        //需要请求网络图片设置到realImageView->使用SDWebkuangija->CocoaPods加载

        //根据图片的宽度决定图片的宽度
        CGFloat imageViewH = YYhScreenW / self.adItem.w * self.adItem.h;
        self.realImageView.frame = CGRectMake(0, 0, YYhScreenW, imageViewH);

        [self.realImageView sd_setImageWithURL:adURL];


//        NSLog(@"%@", adItem);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];

}

@end
