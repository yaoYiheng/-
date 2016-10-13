//
//  Item.h
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
/** item的图片名*/
@property (nonatomic, strong) NSString *icon;
/** item的名称*/
@property (nonatomic, strong) NSString *title;

+(instancetype)itemWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
