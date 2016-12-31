//
//  DrawView.h
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2016/12/31.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

/**
 clear all pathes
 */
- (void)allClear;

/**
 Undo last
 */
- (void)undo;

/**
 set eraser for the drawView
 */
- (void)eraser;

- (void)setLineWidth:(CGFloat) lineWidth;
- (void)setLineColor:(UIColor *) lineColor;

@end
