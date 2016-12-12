//
//  massageViewController.m
//  16_12_12_UITabBarController
//
//  Created by 姚懿恒 on 2016/12/12.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "massageViewController.h"
#import "UIImage+Image.h"

#define imageViewHeight 200
#define originalOffsetY 244

@interface massageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//图片父控件的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end

@implementation massageViewController

NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题
    UILabel *title = [[UILabel alloc] init];
    title.text = @"个人详情页";
    title.textColor = [UIColor colorWithWhite:0 alpha:0];
    [title sizeToFit];
    self.navigationItem.titleView = title;
    //导航控制器下的scrollView都会自动设置偏移量, 以下方法取消.
    self.automaticallyAdjustsScrollViewInsets = NO;


    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.contentInset = UIEdgeInsetsMake(originalOffsetY, 0, 0, 0);

    //隐藏导航条以及阴影线.
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:0 target:self action:@selector(addContact)];
}
- (void)addContact{

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算偏移量. 并通过该偏移量求出图片高度.
    CGFloat offsetBetweenImageViewAndTabel = originalOffsetY + scrollView.contentOffset.y;
    CGFloat currentHeightOfImageView = imageViewHeight - offsetBetweenImageViewAndTabel;
    if (currentHeightOfImageView < 64) {
        currentHeightOfImageView = 64;
    }
    self.imageViewHeightConstraint.constant = currentHeightOfImageView;

    //根据透明度来生成图片
    //找最大值/
    CGFloat alpha = offsetBetweenImageViewAndTabel * 1 / 136.0;
    if (alpha >= 1) {
        alpha = 0.99;
    }

    //拿到标题
    UILabel *titleL = (UILabel *)self.navigationItem.titleView;
    titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];

    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    //把颜色生成图片
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    //修改导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.textLabel.text = @"张mm";
    return cell;
}



@end
