//
//  YYHRegisterView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHRegisterView.h"
@interface YYHRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;


@end
@implementation YYHRegisterView

+ (instancetype)logInView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    UIImage *image = _loginRegisterButton.currentBackgroundImage;

    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];

    // 让按钮背景图片不要被拉伸
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}
@end
