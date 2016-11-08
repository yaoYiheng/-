//
//  YHStatusCell.m
//  16_11_08_storyboard_不等高cell
//
//  Created by 姚懿恒 on 2016/11/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHStatusCell.h"
#import "YHStatus.h"

@interface YHStatusCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureBottom;

@end
@implementation YHStatusCell


- (void)setStatus:(YHStatus *)status{
    _status = status;
    self.iconImageView.image = [UIImage imageNamed:status.icon];
    self.nameLabel.text = status.name;
    self.text_Label.text = status.text;

    if (status.vip) {
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else{
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    if (status.picture) {
        self.pictureImageView.hidden = NO;
        self.pictureImageView.image = [UIImage imageNamed:status.picture];
        self.pictureH.constant = 100;
        self.pictureBottom.constant = 10;
    }
    else{
        self.pictureImageView.hidden = YES;
        self.pictureH.constant = 0;
        self.pictureBottom.constant = 0;
    }

}

@end
