//
//  ViewController.m
//  17_03_11_block传值_代理与block
//
//  Created by 姚懿恒 on 2017/3/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
@interface ViewController ()<ModalViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //点击控制器后跳转到Modal控制器
    ModalViewController *modalVC = [[ModalViewController alloc] init];
    modalVC.view.backgroundColor = [UIColor orangeColor];
//    modalVC.delegate = self;

    //对myBlock进行定义
    modalVC.myBlock = ^(NSString *value){
        NSLog(@"%@", value);
    };

    [self presentViewController:modalVC animated:YES completion:nil];
}
//- (void)modalViewController:(ModalViewController *)modalViewController sendingValue:(NSString *)value{
//    NSLog(@"%@", value);
//}

@end
