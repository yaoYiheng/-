//
//  ModalViewController.h
//  17_03_11_block传值_代理与block
//
//  Created by 姚懿恒 on 2017/3/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

@optional
- (void)modalViewController:(ModalViewController *)modalViewController sendingValue:(NSString *)value;

@end
@interface ModalViewController : ViewController

/** 代理属性*/
//@property (nonatomic, weak)  id<ModalViewControllerDelegate> delegate;

///** <#comments#>*/
//@property (nonatomic, strong) void(^myBlock)(NSString * value);

@end
