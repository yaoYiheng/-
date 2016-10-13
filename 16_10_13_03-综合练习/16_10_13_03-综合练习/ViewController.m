//
//  ViewController.m
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
添加项目到购物车

 @param sender 添加
 */
- (IBAction)addItem:(UIButton *)sender {

    //定义一些变量用来计算9宫格图标的x, y值
    int col = 3;
    NSInteger itemIndex = self.cartView.subviews.count;
    CGFloat itemWidth = 100;
    CGFloat itemHeigh = 150;

    CGFloat hGap = (self.view.frame.size.width - col * itemWidth ) / (col - 1);
    CGFloat vGap = (self.cartView.frame.size.height - 2 * itemHeigh) ;


    CGFloat x = (hGap + itemWidth) * (itemIndex % col);
    CGFloat y = (vGap + itemHeigh) * (itemIndex / col);

   // ==================

    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeigh)];

    itemView.backgroundColor = [UIColor grayColor];

    [self.cartView addSubview:itemView];

    //更改按钮的可点状态
    sender.enabled = (itemIndex != 5);
    _removeButton.enabled = YES;
    
}

/**
 删除项目

 @param sender 删除
 */
- (IBAction)removeItem:(UIButton *)sender {

    //取出最后一个item, 并移除.
    UIView *lastView = [self.cartView.subviews lastObject];
    [lastView removeFromSuperview];

    _addButton.enabled = YES;
    sender.enabled = (self.cartView.subviews.count != 0);
}

@end
