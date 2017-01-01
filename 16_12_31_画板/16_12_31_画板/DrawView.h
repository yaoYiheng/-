//
//  DrawView.h
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2016/12/31.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
/** 是否有绘制*/
@property (nonatomic, assign) BOOL Drawing;

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

- (void)setLineWidths:(CGFloat) lineWidth;
- (void)setLineColors:(UIColor *) lineColor;

@end
