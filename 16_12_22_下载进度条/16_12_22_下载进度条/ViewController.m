//
//  ViewController.m
//  16_12_22_下载进度条
//
//  Created by 姚懿恒 on 2016/12/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "loadingView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (weak, nonatomic) IBOutlet loadingView *progressView;


@end

@implementation ViewController
- (IBAction)loadingSlider:(UISlider *)sender {
    self.currentValueLabel.text = [NSString stringWithFormat:@"%.2f%%", sender.value * 100];
    self.progressView.progressValue = sender.value;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
