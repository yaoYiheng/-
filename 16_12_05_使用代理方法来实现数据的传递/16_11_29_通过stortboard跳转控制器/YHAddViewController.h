//
//  YHAddViewController.h
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHAddItem.h"


@class YHAddViewController;

//编写协议
@protocol addViewDelegate <NSObject>

//协议方法
@optional
- (void) addViewController:(YHAddViewController *)addViewController addItem:(YHAddItem *)addItem;

@end

@interface YHAddViewController : ViewController


/** 设置代理属性*/
@property (nonatomic, weak) id<addViewDelegate> delegate;
@end
