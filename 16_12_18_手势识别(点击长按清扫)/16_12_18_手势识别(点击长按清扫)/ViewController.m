//
//  ViewController.m
//  16_12_18_手势识别(点击长按清扫)
//
//  Created by 姚懿恒 on 2016/12/18.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
//
//    [self.imageView addGestureRecognizer:longPress];

    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
    [self.imageView addGestureRecognizer:swip];
//    [self setUpTap];

}
- (void)swip:(UISwipeGestureRecognizer *)swip{
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    NSLog(@"%s", __func__);
}
- (void)longPress{

    NSLog(@"%s", __func__);
}
//3.实现手势方法
- (void)tap{
    NSLog(@"%s",__func__);
    
}
- (void)setUpTap{
    //1.创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //2.将手势添加到想要实现的子控件上
    [self.imageView addGestureRecognizer:tap];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
