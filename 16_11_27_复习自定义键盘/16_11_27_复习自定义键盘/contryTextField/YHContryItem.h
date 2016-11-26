//
//  YHContryItem.h
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHContryItem : NSObject
/** 国家名*/
@property (nonatomic, strong) NSString *name;
/** 国旗*/
@property (nonatomic, strong)  UIImage *icon;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)contryItemWithDictionary:(NSDictionary *)dict;


@end
