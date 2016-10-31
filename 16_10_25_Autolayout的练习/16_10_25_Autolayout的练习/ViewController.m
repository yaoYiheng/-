//
//  ViewController.m
//  16_10_25_Autolayout的练习
//
//  Created by 姚懿恒 on 2016/10/25.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];

    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];


    [self.view addSubview:redView];
    [self.view addSubview:blueView];

    //设置redView的约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {


        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(blueView.mas_left).offset(-30);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);

        make.width.mas_equalTo(blueView.mas_width);
        make.height.mas_equalTo(50);

    }];

    //设置blueView的约束
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.offset(-30);
        make.top.mas_equalTo(redView.mas_top);
        make.bottom.mas_equalTo(redView.mas_bottom);
    }];

    //调用该方法更新约束.
    [redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
    }];

    //删除之前所有约束, 并添加新约束
//    [redView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        do something
//    }];
}

/**
 添加一个宽高为100, 并位于中点的子控件.
 */
- (void)test{

    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];

    [self.view addSubview:redView];

    [redView mas_makeConstraints:^(MASConstraintMaker *make) {

        //设置子控件的宽高
        make.width.height.equalTo(@100);

        //设置子控件的中心点.
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);


        //简化写法, 设置子控件的size 与中心点
        //可以省略 mas_centerX 和 mas_centerY.

        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.mas_equalTo(self.view);
        
        
    }];

}



/**
 制作约束, 使子控件距离父控件保持20的间距
 */
- (void)edge{

    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];

    //
    /**
     调用mas_makeConstraints方法, 为子控件设置约束.
     其中 equalTo(self.view.mas_top).multipliedBy(1.0).默认可以省略
     */
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view.mas_top).multipliedBy(1.0).offset(20);
        make.left.equalTo(self.view.mas_left).multipliedBy(1.0).offset(20);
        make.right.equalTo(self.view.mas_right).multipliedBy(1.0).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).multipliedBy(1.0).offset(-20);
    }];

    //精简写法  其中的 and 也可以省略
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.offset(20);
        make.right.and.bottom.offset(-20);
    }];

    //进一步精简
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];

}

@end
