//
//  YHContactTableViewController.h
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/1.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHAddItem;

@interface YHContactTableViewController : UITableViewController
/** 用户名*/
@property (nonatomic, strong) NSString *userName;
/** addItem*/
@property (nonatomic, strong) YHAddItem *addItem;

@end
