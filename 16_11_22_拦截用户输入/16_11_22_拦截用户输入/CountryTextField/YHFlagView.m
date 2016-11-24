//
//  YHFlagView.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHFlagView.h"
#import "YHFlagItem.h"
@interface YHFlagView()
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@end

@implementation YHFlagView
+(instancetype)flagView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YHFlagView class]) owner:nil options:nil] lastObject];
}

- (void)setFlagItem:(YHFlagItem *)flagItem{
    _flagItem = flagItem;
    self.countryLabel.text = flagItem.name;
    self.flagImageView.image = flagItem.icon;
}

@end
