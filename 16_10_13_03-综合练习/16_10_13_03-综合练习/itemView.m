//
//  ItemView.m
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "itemVIew.h"
#import "Item.h"

@interface itemVIew()
/** iconView*/
@property (nonatomic, weak) UIImageView *iconView ;
/** label*/
@property (nonatomic, weak) UILabel *titleLabel ;
@end

@implementation itemVIew

/**
 初始化子控件
不要设置frame
 */
-(instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }

    return self;
}
-(instancetype)initViewWithItems:(Item *)item{
    if (self = [super init]) {
        //先创建在赋值
        [self setUp];
        self.item = item;
    }
    return self;
}

+(instancetype)itemWithItems:(Item *)item{

    return [[self alloc] initViewWithItems:item];
}

-(void)setUp{

    //创建itemVIew中的UIImageView跟UILabel
    UIImageView *iconView = [[UIImageView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];

    //设置它们的背景颜色
    iconView.backgroundColor = [UIColor blueColor];
    titleLabel.backgroundColor = [UIColor yellowColor];
    //设置标题居中显示
    titleLabel.textAlignment = NSTextAlignmentCenter;

    self.iconView = iconView;
    self.titleLabel = titleLabel;

    //将其添加到单个的itemVIew当中
    [self addSubview:iconView];
    [self addSubview:titleLabel];

}

/**
 布局子控件, 可通过该方法拿到item的frame, 从而对子控件的宽高进行设置
 */
-(void)layoutSubviews{

    [super layoutSubviews];
    CGFloat itemWidth = self.frame.size.width;
    CGFloat itemHeight = self.frame.size.height;

    self.iconView.frame = CGRectMake(0, 0, itemWidth, itemWidth);
    self.titleLabel.frame = CGRectMake(0, itemWidth, itemWidth, itemHeight - itemWidth);


}

/**
 设置数据

 @param item 只要外部传入数据就会调用
 */
-(void)setItem:(Item *)item{

    _item = item;

    self.iconView.image = [UIImage imageNamed:item.icon];
    self.titleLabel.text = item.title;
    
}



@end
