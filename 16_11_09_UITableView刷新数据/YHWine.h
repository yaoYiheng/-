//
//  YHWine.h
//  16_11_09_UITableView刷新数据
//
//  Created by 姚懿恒 on 2016/11/9.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHWine : NSObject
/** 酒名*/
@property (nonatomic, copy) NSString *name;
/** 图片*/
@property (nonatomic, copy) NSString *image;
/** 价格*/
@property (nonatomic, copy) NSString *money;
/**是否勾选*/
@property (nonatomic, assign, getter=isSelected) BOOL selected;


@end
