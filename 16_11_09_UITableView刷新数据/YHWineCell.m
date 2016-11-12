//
//  YHWineCell.m
//  16_11_09_UITableView刷新数据
//
//  Created by 姚懿恒 on 2016/11/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHWineCell.h"
#import "YHWine.h"
@interface YHWineCell()
/** 勾选的图标*/
@property (nonatomic, weak) UIImageView *selectedImageView;

@end
@implementation YHWineCell
#pragma mark 新添加了一个子控件, 在该方法中完成控件的创建与基本设置.
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *selectedImageView = [[UIImageView alloc] init];
        selectedImageView.image = [UIImage imageNamed:@"check"];
        self.selectedImageView.hidden = YES;
        [self.contentView addSubview:selectedImageView];
        self.selectedImageView = selectedImageView;
    }
    return self;
}
#pragma mark 在该方法中完成对子控件的布局
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置 selectedImageView 的位置及宽高
    CGFloat WH = 24;
    CGFloat selectedImageViewX = self.contentView.frame.size.width - WH - 10;
    CGFloat selectedImageViewY = (self.contentView.frame.size.height - WH) * 0.5;
    self.selectedImageView.frame = CGRectMake(selectedImageViewX, selectedImageViewY, WH, WH);

    //更改textLabel 的宽度
    CGRect temp = self.textLabel.frame;
    temp.size.width = self.contentView.frame.size.width - self.textLabel.frame.origin.x - 20 - WH;
    self.textLabel.frame = temp;
}

- (void)setWine:(YHWine *)wine{
    _wine = wine;
    self.imageView.image = [UIImage imageNamed :wine.image];
    self.textLabel.text = wine.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", wine.money];

    if (wine.isSelected) { //如果模型处于被选中状态, 就将控件显示

        self.selectedImageView.hidden = NO;
    }
    else{

        self.selectedImageView.hidden = YES;
    }
}

@end
