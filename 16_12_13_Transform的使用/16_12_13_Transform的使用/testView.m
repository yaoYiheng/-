//
//  testView.m
//  16_12_13_Transform的使用
//
//  Created by 姚懿恒 on 2016/12/16.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "testView.h"


@implementation testView

- (void)awakeFromNib{
    [super awakeFromNib];
    UIToolbar *toolBar = [[UIToolbar alloc] init];
//    toolBar.frame = self.bounds;
    [self addSubview:toolBar];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.alpha = 0.8;
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.and.left.offset(20);
        make.right.and.bottom.offset(-20);


    }];




    
}
+ (instancetype)item{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
//    }
//
//
//    return self;
//}
//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
//    }
//    return self;
//}
@end
