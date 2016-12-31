//
//  DrawView.m
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2016/12/31.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "DrawView.h"
@interface DrawView()


/** 当前路径*/
@property (nonatomic, strong) UIBezierPath *path;

/** 所有路径的数组*/
@property (nonatomic, strong) NSMutableArray *allPathArray;

/** 线宽*/
@property (nonatomic, assign) CGFloat lineWidth;
/** 线的颜色*/
@property (nonatomic, strong) UIColor *lineColor;
@end


@implementation DrawView
- (NSMutableArray *)allPathArray{
    if (!_allPathArray) {
        _allPathArray = [NSMutableArray array];
    }
    return _allPathArray;
}
#pragma mark 初始化
- (void)awakeFromNib{
//    [super awakeFromNib];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGes];

    self.lineWidth = 10;
    self.lineColor = [UIColor orangeColor];

}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{


}

- (void)pan:(UIPanGestureRecognizer *)panGesture{

    CGPoint currentPoint = [panGesture locationInView:self];

    if (panGesture.state == UIGestureRecognizerStateBegan) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        self.path = path;
        [path moveToPoint:currentPoint];
        [self.allPathArray addObject:path];

    }else if (panGesture.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }

}
- (void)drawRect:(CGRect)rect{
    for (UIBezierPath *path  in self.allPathArray) {
        [self.lineColor set];
        [path setLineWidth:self.lineWidth];
        [path stroke];
    }
    NSLog(@"%f", self.lineWidth);
}

#pragma mark 画板相关的功能
/**
 clear all pathes
 */
- (void)allClear{
    [self.allPathArray removeAllObjects];
    [self setNeedsDisplay];

}

/**
 Undo last
 */
- (void)undo{
    [self.allPathArray removeLastObject];
    [self setNeedsDisplay];

}

/**
 set eraser for the drawView
 */
- (void)eraser{
    [self setLineColor:[UIColor whiteColor]];

}
- (void)setLineWidth:(CGFloat) lineWidth{
    _lineWidth = lineWidth;
}
- (void)setLineColor:(UIColor *) lineColor{
    _lineColor = lineColor;
}


@end
