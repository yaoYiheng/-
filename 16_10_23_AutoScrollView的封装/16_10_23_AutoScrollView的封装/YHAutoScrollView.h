//
//  YHAutoScrollView.h
//  16_10_23_AutoScrollView的封装
//
//  Created by 姚懿恒 on 2016/10/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHAutoScrollView : UIView

/** 图片名数组*/
@property (nonatomic, strong) NSArray *imageNames;
+(instancetype)autoScrollView;

@end
