//
//  YHWineCell.m
//  16_11_15_购物车
//
//  Created by 姚懿恒 on 2016/11/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHWineCell.h"
#import "YHWine.h"
#import "YHCircleButton.h"

@interface YHWineCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;



@end

@implementation YHWineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark 减少一瓶
- (IBAction)remove {
    //修改模型数据
    self.wine.count --;
    if (self.wine.count <= 0) {
        self.minusButton.enabled = NO;
    }
    //更改
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];

    //向通知中心发布消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeClickButton" object:self];
}
- (IBAction)add {
    self.wine.count ++;
    self.minusButton.enabled = YES;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];

    //编写消息, 并想通知中心发布.
    NSNotification *note = [NSNotification notificationWithName:@"addClickButton" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:note];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setWine:(YHWine *)wine{
    _wine = wine;

    self.imageImageView.image = [UIImage imageNamed:wine.image];
    self.nameLabel.text = wine.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", wine.money];
    self.countLabel.text = [NSString stringWithFormat:@"%d", wine.count];
    //根据模型判断修改是否更改按钮的属性
    self.minusButton.enabled = self.wine.count > 0;

}
@end
