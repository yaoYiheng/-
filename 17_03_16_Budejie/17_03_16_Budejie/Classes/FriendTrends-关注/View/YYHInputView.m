//
//  YYHInputView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHInputView.h"
@interface YYHInputView()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation YYHInputView

//- (void)awakeFromNib{
////    [super awakeFromNib];
//
//    UIImage *bgImage = [_loginButton.currentBackgroundImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5];
//
//    [_loginButton setBackgroundImage:bgImage forState:UIControlStateNormal];
//}

+ (instancetype)middleView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
