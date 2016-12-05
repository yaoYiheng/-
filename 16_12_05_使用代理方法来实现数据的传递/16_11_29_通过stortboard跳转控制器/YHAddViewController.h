//
//  YHAddViewController.h
//  16_11_29_通过stortboard跳转控制器
//
//  Created by 姚懿恒 on 2016/12/4.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"


@class YHContactTableViewController;



@interface YHAddViewController : ViewController
/** 联系人控制器*/
@property (nonatomic, weak)  YHContactTableViewController *contantViewController;


@end
