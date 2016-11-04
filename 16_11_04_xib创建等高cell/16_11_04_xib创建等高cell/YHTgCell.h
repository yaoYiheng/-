//
//  YHTgCell.h
//  16_11_04_xib创建等高cell
//
//  Created by 姚懿恒 on 2016/11/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTgCell : NSObject
/** 图片*/
@property (nonatomic, strong) NSString *icon;
/** 标题*/
@property (nonatomic, strong) NSString *title;
/** 价格*/
@property (nonatomic, strong) NSString *price;
/** 购买数*/
@property (nonatomic, strong) NSString *buyCount;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)tgcellWithDictionary:(NSDictionary *)dict;

@end
