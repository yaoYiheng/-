//
//  ItemView.m
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/17.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ItemView.h"
#import "Item.h"

@interface ItemView()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ItemView

/**
 快速构造方法

 */
+(instancetype)itemView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 设置模型数据

 */
-(void)setItem:(Item *)item{
    _item = item;
    self.iconView.image = [UIImage imageNamed:item.icon];
    self.titleLabel.text = item.title;
}

@end
