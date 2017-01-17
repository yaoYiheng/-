//
//  YYHNewFeatureCollectionViewCell.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNewFeatureCollectionViewCell.h"
#import "YYHTabBarViewController.h"

@interface YYHNewFeatureCollectionViewCell ()
/** UIImageView*/
@property (nonatomic, weak) UIImageView *backGroundImageView;
/** 立即体验按钮*/
@property (nonatomic, weak) UIButton *experienceNow;

@end


@implementation YYHNewFeatureCollectionViewCell


/**
 懒加载按钮, 只添加一次即可.
设置初始化为隐藏状态, 只有当cell为最后一个时, 才显示
 */
- (UIButton *)experienceNow{
    if (!_experienceNow) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];


        [button setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        //先调用该方法, 在对其中心点进行设置.
        [button sizeToFit];

        button.center = CGPointMake(self.Width * 0.5, self.Height * 0.9);
        button.hidden = YES;

        [button addTarget:self action:@selector(startButtonOnclick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _experienceNow = button;
    }
    return _experienceNow;
}

/**
 当点击按钮时, 跳转到主框架.
 通过
 */
- (void)startButtonOnclick{
    YYHTabBarViewController *tabBarViewController = [[YYHTabBarViewController alloc] init];
    //通过应用程序单例拿到主窗口, 设置其根控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarViewController;

}
- (UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];

        [self.contentView addSubview:imageView];

        _backGroundImageView = imageView;
    }
    return _backGroundImageView;
}

- (void)setCellImage:(UIImage *)cellImage{
    _cellImage = cellImage;
    self.backGroundImageView.image = cellImage;

}

/**
 如果是最后一张就显示按钮

 @param lastPage <#lastPage description#>
 */
- (void)setLastPage:(BOOL)lastPage{
    _lastPage = lastPage;
    if (lastPage) {
        self.experienceNow.hidden = NO;
    }
    else{
        self.experienceNow.hidden = YES;
    }
}

@end
