//
//  YHContryView.m
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHContryView.h"
#import "YHContryItem.h"

@interface YHContryView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@end

@implementation YHContryView
+ (instancetype)contryView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YHContryView class]) owner:nil options:nil] lastObject];
}

- (void)setCountryItem:(YHContryItem *)countryItem{
    _countryItem = countryItem;
    self.nameLabel.text = countryItem.name;
    self.flagImageView.image = countryItem.icon;
}

@end
