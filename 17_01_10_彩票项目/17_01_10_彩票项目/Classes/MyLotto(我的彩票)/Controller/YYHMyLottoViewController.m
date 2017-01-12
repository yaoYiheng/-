//
//  YYHMyLottoViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/10.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHMyLottoViewController.h"

@interface YYHMyLottoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *LogInButton;

@end

@implementation YYHMyLottoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.设置拉伸按钮图片
    //1.1拿到按钮背景图片
    UIImage *image = self.LogInButton.currentBackgroundImage;

    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    [self.LogInButton setBackgroundImage:image forState:UIControlStateNormal];

    //2.设置导航栏左侧

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [button setTitle:@"客服" forState:UIControlStateNormal];
    //设置完button的背景图片与文字 后需要设置其尺寸. 调用sizeToFit
    [button sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    //3. 设置导航栏右侧
    //因为有渲染效果, 所以调用之前写好的分类方法, 返回一张不带有渲染的图片
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoutRendering:@"Mylottery_config"] style:0 target:self action:@selector(configure)];
}
- (void)configure{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
