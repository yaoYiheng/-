//
//  YHEditViewController.h
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/6.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHAddItem, YHEditViewController;


@protocol EditViewDelegate <NSObject>

@optional
//实现代理方法.
- (void)edittingViewController:(YHEditViewController *)editingViewController addItem:(YHAddItem *)additem;

@end
@interface YHEditViewController : UIViewController


/** 模型*/
@property (nonatomic, strong) YHAddItem *addItem;
/** 设置代理属性*/
@property (nonatomic, weak) id<EditViewDelegate> delegate;
@end
