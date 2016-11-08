//
//  YHStatus.h
//  16_11_08_storyboard_不等高cell
//
//  Created by 姚懿恒 on 2016/11/8.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHStatus : NSObject
/** 头像*/
@property (nonatomic, copy) NSString *icon;
/** 昵称*/
@property (nonatomic, copy) NSString *name;
/** 内容*/
@property (nonatomic, copy) NSString *text;
/** 图片*/
@property (nonatomic, copy) NSString *picture;
/**是否VIP*/
@property (nonatomic, assign, getter=isVip) BOOL vip;


@end
