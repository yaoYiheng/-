//
//  YHItemView.m
//  16_10_16_05_通过xib自定义View
//
//  Created by 姚懿恒 on 2016/10/16.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHItemView.h"
#import "YHItems.h"

@interface YHItemView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation YHItemView

/**
 创建快速构造方法

 */
+(instancetype)items{
    return [[[NSBundle mainBundle] loadNibNamed:@"YHItemView" owner:nil options:nil] lastObject];
}

/**
 在该方法中向xib中的子控件添加控件
 */
-(void)awakeFromNib{
    [super awakeFromNib];

    //加载毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.alpha = 0.7;

    [self.iconView addSubview:toolBar];

}
/**
 重写get方法, 将传入的数据写到相关的属性中.


 */
-(void)setItems:(YHItems *)items{
    _items = items;

    self.iconView.image = [UIImage imageNamed:items.iconName];
    self.titleLabel.text = items.title;
}


@end
