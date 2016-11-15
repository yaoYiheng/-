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
    self.wine.count --;
    if (self.wine.count <= 0) {
        self.minusButton.enabled = NO;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
}
- (IBAction)add {
    self.wine.count ++;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    self.minusButton.enabled = self.wine.count;
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

}
@end
