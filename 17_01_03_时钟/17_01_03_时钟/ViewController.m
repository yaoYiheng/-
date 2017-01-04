//
//  ViewController.m
//  17_01_03_时钟
//
//  Created by 姚懿恒 on 2017/1/3.
//  Copyright © 2017年 姚懿恒. All rights reserved.

//角度转弧度
#define angle2Radio(angle) ((angle) / 180.0 * M_PI)


#import "ViewController.h"

@interface ViewController ()
/** 秒针*/
@property (nonatomic, weak) CALayer *secHandLayer;
/** 分针*/
@property (nonatomic, weak) CALayer *minHandLayer;
/** 时针*/
@property (nonatomic, weak) CALayer *hourHandLayer;

@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;

/** 时间组件*/
@property (nonatomic, weak) NSDateComponents *cmp;

@end

@implementation ViewController
- (NSDateComponents *)cmp{
    if (!_cmp) {
        //获取当前是多少秒.
        NSCalendar *calendar = [NSCalendar currentCalendar];
        //获取日历当中的组件.年,月,日 ,时,分,秒
        //fromDate:从哪个时间
        NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
        self.cmp = cmp;
    }
    return _cmp;
}


#pragma mark -配置秒, 分, 时
- (void)configureTime {


    if (self.cmp) {
        /**
         当前 秒数 * 每秒钟旋转的度数
         */

        self.secHandLayer.transform = CATransform3DMakeRotation(self.cmp.second * M_PI / 60 * 2, 0, 0, 1);
        self.minHandLayer.transform = CATransform3DMakeRotation(self.cmp.minute * M_PI /60 * 2, 0, 0, 1);

        /**
         当前小时数 * 每小时旋转的度数 + 当前分钟 * 每一分钟时针旋转的度数.

         */
        self.hourHandLayer.transform = CATransform3DMakeRotation(self.cmp.hour * M_PI * 2 / 12 + self.cmp.minute * M_PI / 360 ,0, 0, 1);
    }


}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureSecHand];
    [self configureMinHand];
    [self configureHourHand];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(configureTime) userInfo:nil repeats:YES];
}
#pragma mark -秒分时针
- (void)configureSecHand{

    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 2, 100);
    //旋转, 缩放, 均是围绕锚点进行.
    layer.anchorPoint = CGPointMake(0.5, 0.9);
    layer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.height / 2);

    [self.clockImageView.layer addSublayer:layer];
    self.secHandLayer = layer;

}

- (void)configureMinHand{

    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 5, 75);
    layer.anchorPoint = CGPointMake(0.5, 0.95);
    layer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.height / 2);
    layer.cornerRadius = 2;

    self.minHandLayer = layer;
    [self.clockImageView.layer addSublayer:layer];

}


- (void)configureHourHand{

    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 8, 50);
    layer.anchorPoint = CGPointMake(0.5, 0.9);
    layer.position = CGPointMake(self.clockImageView.bounds.size.width / 2, self.clockImageView.bounds.size.height / 2);

    layer.cornerRadius = 4;
    [self.clockImageView.layer addSublayer:layer];
    self.hourHandLayer = layer;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
