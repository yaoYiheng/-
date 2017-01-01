//
//  DrawView.m
//  16_12_31_画板
//
//  Created by 姚懿恒 on 2016/12/31.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "DrawView.h"
#import "YHBezierPath.h"
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
    [super awakeFromNib];
    [self setUp];


}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panGes];

    //为线宽与颜色设置初始值
    self.lineWidth = 1;
    self.lineColor = [UIColor orangeColor];
    self.Drawing = NO;

}
#pragma mark 手势方法.
- (void)pan:(UIPanGestureRecognizer *)panGesture{

    CGPoint currentPoint = [panGesture locationInView:self];

    if (panGesture.state == UIGestureRecognizerStateBegan) {

        //使用自定义的YHBezierPath, 含有 pathColor属性.
        YHBezierPath *path = [YHBezierPath bezierPath];
        self.path = path;

        /**
         保存路径的相关属性, 由于系统自带的UIBezierPath没有 pathColor属性,为了满足
         需求则需要重写类, 添加需要的属性.
        */
        [path setLineWidth:self.lineWidth];
        path.pathColor = self.lineColor;

        [path moveToPoint:currentPoint];
        [self.allPathArray addObject:path];

    }else if (panGesture.state == UIGestureRecognizerStateChanged){

        //手指在屏幕上移动时, 添加一条线到手指的点, 并立刻重绘.
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];

    }
    self.Drawing = self.allPathArray.count;


}
#pragma mark  绘图
- (void)drawRect:(CGRect)rect{
    for (YHBezierPath *path in self.allPathArray) {

        //拿到对应path里保存的颜色, 从而进行绘制.
        [path.pathColor set];
        [path stroke];
    }
}

#pragma mark 画板相关的功能
/**
 clear all pathes
 */
- (void)allClear{
    [self.allPathArray removeAllObjects];
    [self setNeedsDisplay];
    self.Drawing = NO;

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
- (void)setLineWidths:(CGFloat) lineWidth{
    self.lineWidth = lineWidth;
}
- (void)setLineColors:(UIColor *) lineColor{
    self.lineColor = lineColor;
}


@end
