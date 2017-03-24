//
//  YYHFastLoginView.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/24.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHFastLoginView.h"

@implementation YYHFastLoginView

+ (instancetype)fastLoginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
