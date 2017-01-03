//
//  ViewController.m
//  17_01_03_时钟
//
//  Created by 姚懿恒 on 2017/1/3.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 秒针*/
@property (nonatomic, weak) CALayer *secHandLayer;
/** 分针*/
@property (nonatomic, weak) CALayer *minHandLayer;
/** 时针*/
@property (nonatomic, weak) CALayer *hourHandLayer;

@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;

/** <#comments#>*/
@property (nonatomic, weak) NSDateComponents *cmp;

@end

@implementation ViewController

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
