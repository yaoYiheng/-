//
//  ViewController.m
//  16_12_22_基本线条绘制
//
//  Created by 姚懿恒 on 2016/12/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet drawView *myView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc
                                              ] initWithTarget:self action:@selector(rotatioGes:)];
    [self.myView addGestureRecognizer:rotation];
}

- (void)rotatioGes:(UIRotationGestureRecognizer *)rotation{
    self.myView.transform = CGAffineTransformRotate(self.myView.transform, rotation.rotation);
    [rotation setRotation:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
