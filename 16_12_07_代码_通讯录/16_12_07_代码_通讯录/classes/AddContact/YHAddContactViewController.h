//
//  YHAddContactViewController.h
//  16_12_07_代码_通讯录
//
//  Created by 姚懿恒 on 2016/12/7.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHContactItems, YHAddContactViewController;

@protocol AddContactDelegate <NSObject>


@optional
- (void)addContactViewController:(YHAddContactViewController *)contactView contactItem:(YHContactItems*) contactItem;

@end
@interface YHAddContactViewController : UIViewController

/** 代理属性*/
@property (nonatomic, weak)  id<AddContactDelegate> delegate;

@end
