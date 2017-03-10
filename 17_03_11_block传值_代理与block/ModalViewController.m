//
//  ModalViewController.m
//  17_03_11_block传值_代理与block
//
//  Created by 姚懿恒 on 2017/3/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //点击跳转的控制器, 向viewController传递值.
    if ([self.delegate respondsToSelector:@selector(modalViewController:sendingValue:)]) {
        [self.delegate modalViewController:self sendingValue:@"哈哈哈"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
