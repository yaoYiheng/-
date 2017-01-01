//
//  YHImageView.h
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2017/1/1.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHImageView;

@protocol YHImageViewDelegate <NSObject>

@optional
- (void)YHImageView:(YHImageView *) imageView image:(UIImage *)image;

@end


@interface YHImageView : UIView
/** 代理属性*/
@property (nonatomic, weak)  id<YHImageViewDelegate> delegate;

/** 传递过来的image*/
@property (nonatomic, strong) UIImage *passedImage;


@end
