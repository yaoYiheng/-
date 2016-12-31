//
//  ViewController.m
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2016/12/31.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

#pragma mark -画板功能

- (IBAction)allClear:(UIBarButtonItem *)sender {
    [self.drawView allClear];
}


- (IBAction)undo:(UIBarButtonItem *)sender {
}
- (IBAction)eraser:(UIBarButtonItem *)sender {
}
- (IBAction)photoFromAlbum:(UIBarButtonItem *)sender {
}
- (IBAction)savePicture:(UIBarButtonItem *)sender {
}

#pragma mark -view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
