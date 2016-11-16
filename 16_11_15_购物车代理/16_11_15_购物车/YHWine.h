//
//  YHWine.h
//  16_11_15_购物车
//
//  Created by 姚懿恒 on 2016/11/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHWine : NSObject

@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *image;
/** 购买个数*/
@property int count;

@end
