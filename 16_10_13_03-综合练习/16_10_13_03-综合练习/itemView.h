//
//  ItemView.h
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface itemVIew : UIView

/** <#comments#>*/
@property (nonatomic, strong) Item *item;

-(instancetype)initViewWithItems:(Item *)item;
+(instancetype)itemWithItems:(Item *)item;

@end
