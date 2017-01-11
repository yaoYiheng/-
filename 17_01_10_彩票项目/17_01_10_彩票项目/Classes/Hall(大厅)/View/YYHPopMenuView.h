//
//  YYHPopMenuView.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/11.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYHPopMenuView;

@protocol YYHPopMenuViewDelegate <NSObject>

- (void)popMenuViewDidClickOnCloseButton:(YYHPopMenuView *) popMenuView;

@end

@interface YYHPopMenuView : UIView

/** 代理属性*/
@property (nonatomic, weak)  id<YYHPopMenuViewDelegate> delegate;


+ (instancetype)showAtPoint:(CGPoint) point;

- (void)disapperAtPoint:(CGPoint) point;

@end
